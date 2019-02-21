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

    /// First player.
    let player1: PlayerEntity
    /// Second player.
    let player2: PlayerEntity

    /// Number of points gained by first player.
    var player1Points: Int {
        didSet {
            pointsDidChange()
        }
    }
    /// Number of points gained by second player.
    var player2Points: Int {
        didSet {
            pointsDidChange()
        }
    }

    /// State of the game. Computed based of the number of points gained by each player.
    private(set) var state: GameStateEntity

    /// Construct a game.
    /// - Parameter player1: First player.
    /// - Parameter player2: Second player.
    init(player1: PlayerEntity, player2: PlayerEntity) {
        self.player1 = player1
        self.player2 = player2

        player1Points = GameEntity.defaultPoints
        player2Points = GameEntity.defaultPoints

        state = .playing
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
    }

    private mutating func pointsDidChange() {
        state = computeState()
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
}

extension GameEntity: Equatable {}
