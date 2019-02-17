//
//  ScoreboardPresentationModelFactory.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Create scoreboard presentation models.
final class ScoreboardPresentationModelFactory {
    /// Minimum player points for the game to be considered a deuce.
    static var minPointsForDeuce = 3

    /// Factory method for creating a scoreboard presentation model from a game model.
    /// Converts game points(0, 1, 2, 3...) into tennis score(0, 15, 30, 40, deuce, advantage)
    /// - Parameter entity: Game model.
    /// - Returns: The presentation model.
    func createPresentationModel(from entity: GameEntity) -> ScoreboardPresentationModel {
        var presentationModel = ScoreboardPresentationModel()
        presentationModel.player1Name = entity.player1.name
        presentationModel.player2Name = entity.player2.name

        switch entity.state {
        case .playing:
            presentationModel.isFinished = false
            presentationModel.score = createPlayingScore(from: entity)
        case .finished(let winner):
            presentationModel.isFinished = true
            presentationModel.score = "Game won by \(winner.name)"
        }
        return presentationModel
    }

    private func createPlayingScore(from entity: GameEntity) -> String {
        let player1Points = entity.player1Points
        let player2Points = entity.player2Points
        let maxPoints = max(player1Points, player2Points)
        let minPointsForDeuce = ScoreboardPresentationModelFactory.minPointsForDeuce

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
            return "Advantage for \(entity.player1.name)"
        // Player 2 has the advantage
        case (_, _) where maxPoints >= minPointsForDeuce && player1Points < player2Points:
            return "Advantage for \(entity.player2.name)"
        // Unhandled cases
        default:
            fatalError("Unhandled presentation model case")
        }
    }
}

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
