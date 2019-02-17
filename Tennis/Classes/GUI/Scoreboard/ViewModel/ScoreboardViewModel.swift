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
    private let gameEngineFactory: GameEngineFactoryProtocol
    private var gameEngine: GameEngineProtocol!

    deinit {
        gameEngine.remove(observer: self)
    }

    /// Construct the view model.
    /// - Parameter gameEngineFactory: Factory for creating the game engine.
    /// - Parameter player1: First player.
    /// - Parameter player2: Second player.
    init(gameEngineFactory: GameEngineFactoryProtocol,
         player1: PlayerEntity,
         player2: PlayerEntity) {
        self.gameEngineFactory = gameEngineFactory
        self.player1 = player1
        self.player2 = player2

        createEngine()
    }

    /// Simulate a point win for the first player.
    func addPointWinForPlayer1() {
        gameEngine.addPointWin(for: gameEngine.players.first!)
    }

    /// Simulate a point win for the second player.
    func addPointWinForPlayer2() {
        gameEngine.addPointWin(for: gameEngine.players.last!)
    }

    /// Start a new game.
    func reset() {
        gameEngine.remove(observer: self)
        createEngine()
    }

    private func createEngine() {
        gameEngine = gameEngineFactory.createEngine(player1: player1, player2: player2)
        let presentationFactory = ScoreboardPresentationModelFactory()
        presentationModel = presentationFactory.createPresentationModel(from: gameEngine.game)
        gameEngine.add(observer: self)
    }
}

extension ScoreboardViewModel: GameEngineObserver {
    func gameEngine(_ engine: GameEngineProtocol, gameDidUpdate game: GameEntity) {
        let presentationFactory = ScoreboardPresentationModelFactory()
        presentationModel = presentationFactory.createPresentationModel(from: game)
    }
}
