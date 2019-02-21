//
//  GameEntity.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// A tennis game value between two players.
/// Score is based on points: 0, 1, 2, 3, 4...
/// A game is won by the first player to have won at least four points in total
/// and at least two points more than the opponent.
struct GameEntity {
    /// Starting number of points for a player.
    static let defaultPoints = 0
    /// Minimum number of points required for a player to win.
    static let minTotalPointsToWin = 4
    /// Minimum number of advantage points to have for a player to win.
    static let minAdvantagePointsToWin = 2

    /// Minimum player points for the game to be considered a deuce.
    static var minPointsForDeuce = 3

    /// First player.
    let player1: PlayerEntity
    /// Second player.
    let player2: PlayerEntity

    /// State of the game. Computed based of the number of points gained by each player.
    private(set) var state: GameStateEntity

    /// Displayed score, such as 15 - 0.
    private(set) var displayedScore = "0 - 0"

    private var player1Points: Int
    private var player2Points: Int

    /// Construct a game.
    /// - Parameter player1: First player.
    /// - Parameter player2: Second player.
    init(player1: PlayerEntity, player2: PlayerEntity) {
        self.player1 = player1
        self.player2 = player2

        player1Points = GameEntity.defaultPoints
        player2Points = GameEntity.defaultPoints

        state = .playing
        displayedScore = createDisplayedScore()
    }

    /// Simulate a point win for a given player.
    /// - Parameter player: Player who won the point.
    mutating func addPointWin(for player: PlayerEntity) {
        guard case .playing = state else {
            fatalError("Can't add a point win to a finished game")
        }
        
        switch player {
        case player1:
            player1Points += 1
        case player2:
            player2Points += 1
        default:
            fatalError("Player \(player) is not part of this game: \(self)")
        }

        state = computeState()
        displayedScore = createDisplayedScore()
    }

    private func computeState() -> GameStateEntity {
        // Check if at least one player has the minimum number of points required to win.
        let maxPoints = max(player1Points, player2Points)
        guard maxPoints >= GameEntity.minTotalPointsToWin else {
            return .playing
        }

        // Check if one player has at least 2 points more than the apponent.
        let pointDifference = abs(player1Points - player2Points)
        guard pointDifference >= GameEntity.minAdvantagePointsToWin else {
            return .playing
        }

        // The game has a winner.
        let winner = player1Points > player2Points ? player1 : player2
        return .finished(winner)
    }
    
    private func createDisplayedScore() -> String {
        if case .finished(let winner) = state {
            return "Game won by \(winner.name)"
        }

        let maxPoints = max(player1Points, player2Points)
        let minPointsForDeuce = GameEntity.minPointsForDeuce

        switch (player1Points, player2Points) {
        // Both players have < 3 points
        case (_, _) where maxPoints < minPointsForDeuce: fallthrough
        // Only one player has 3 points
        case (_, _) where maxPoints == minPointsForDeuce && player1Points != player2Points:
            return "\(player1Points.toDisplayPoints()) - \(player2Points.toDisplayPoints())"
        // Both players have equal points > 3(= deuce)
        case (_, _) where maxPoints >= minPointsForDeuce && player1Points == player2Points:
            return "Deuce"
        // Player 1 has the advantage
        case (_, _) where maxPoints >= minPointsForDeuce && player1Points > player2Points:
            return "Advantage for \(player1.name)"
        // Player 2 has the advantage
        case (_, _) where maxPoints >= minPointsForDeuce && player1Points < player2Points:
            return "Advantage for \(player2.name)"
        // Unhandled cases
        default:
            fatalError("Unhandled presentation model case")
        }
    }

}

extension GameEntity: Equatable {}

extension Int {
    /// Converts game points(0, 1, 2, 3) into tennis points(0, 15, 30, 40)
    fileprivate func toDisplayPoints() -> Int {
        switch self {
        case 1:
            return 15
        case 2:
            return 30
        case 3:
            return 40
        default:
            return self
        }
    }
}
