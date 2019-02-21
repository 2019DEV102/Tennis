//
//  ScoreboardViewModel.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// ViewModel for Scoreboard screen.
final class ScoreboardViewModel {
    /// Presentation model for the Scoreboard view.
    private(set) var presentationModel: ScoreboardPresentationModel! {
        didSet {
            presentationModelDidChange(presentationModel)
        }
    }
    /// Callback for presentation model changes.
    var presentationModelDidChange: (ScoreboardPresentationModel) -> Void = { (_) in }

    private let player1: PlayerEntity
    private let player2: PlayerEntity
    private var gameEntity: GameEntity!

    /// Construct the view model.
    /// - Parameter player1: First player.
    /// - Parameter player2: Second player.
    init(player1: PlayerEntity,
         player2: PlayerEntity) {
        self.player1 = player1
        self.player2 = player2

        gameEntity = GameEntity(player1: player1, player2: player2)
        updateView()
    }

    /// Simulate a point win for the first player.
    func addPointWinForPlayer1() {
        gameEntity.addPointWin(for: player1)
        updateView()
    }

    /// Simulate a point win for the second player.
    func addPointWinForPlayer2() {
        gameEntity.addPointWin(for: player2)
        updateView()
    }

    /// Start a new game.
    func reset() {
        gameEntity = GameEntity(player1: player1, player2: player2)
        updateView()
    }

    private func updateView() {
        let presentationFactory = ScoreboardPresentationModelFactory()
        presentationModel = presentationFactory.createPresentationModel(from: gameEntity)
    }
}
