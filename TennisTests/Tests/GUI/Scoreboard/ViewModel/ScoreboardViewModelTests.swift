//
//  ScoreboardViewModelTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import XCTest
@testable import Tennis

final class ScoreboardViewModelTests: XCTestCase {
    private var gameEngineMock: GameEngineMock {
        return factoryMock.gameEngineMock
    }

    private var factoryMock: GameEngineFactoryMock!
    private var sut: ScoreboardViewModel!
    private var player1: PlayerEntity {
        return gameEngineMock.game.player1
    }

    private var player2: PlayerEntity {
        return gameEngineMock.game.player2
    }

    override func setUp() {
        super.setUp()

        factoryMock = GameEngineFactoryMock()
        sut = ScoreboardViewModel(gameEngineFactory: factoryMock, player1: player1, player2: player2)
    }

    // MARK: - Test addPointWinForPlayer1 method
    func test_addPointWinForPlayer1() {
        // Given
        var receivedPlayer: PlayerEntity?
        gameEngineMock.addPointWinCallback = { (player) in
            receivedPlayer = player
        }

        // When
        sut.addPointWinForPlayer1()

        // Then
        XCTAssertEqual(player1, receivedPlayer)
    }

    // MARK: - Test addPointWinForPlayer2 method
    func test_addPointWinForPlayer2() {
        // Given
        var receivedPlayer: PlayerEntity?
        gameEngineMock.addPointWinCallback = { (player) in
            receivedPlayer = player
        }

        // When
        sut.addPointWinForPlayer2()

        // Then
        XCTAssertEqual(player2, receivedPlayer)
    }

    // MARK: - Test reset method
    func test_reset() {
        // Given
        var gameUpdated = gameEngineMock.game
        gameUpdated.player1Points = GameEntity.minTotalPointsToWin + 1
        gameEngineMock.simulateGameUpdate(gameUpdated)
        let previousPresentationModel = sut.presentationModel
        factoryMock.gameEngineMock = GameEngineMock()

        // When
        sut.reset()

        // Then
        let currentPresentionModel = sut.presentationModel
        XCTAssertNotEqual(previousPresentationModel, currentPresentionModel)
    }

    // MARK: - Test gameEngine(stateDidChange) method
    func test_gameEngineStateDidChange() {
        // Given
        var gameUpdated = gameEngineMock.game
        gameUpdated.player1Points = GameEntity.minTotalPointsToWin + 1
        let previousPresentationModel = sut.presentationModel

        // When
        gameEngineMock.simulateGameUpdate(gameUpdated)

        // Then
        let currentPresentionModel = sut.presentationModel
        XCTAssertNotEqual(previousPresentationModel, currentPresentionModel)
    }
}

fileprivate final class GameEngineMock {
    var game: GameEntity
    var addPointWinCallback: (PlayerEntity) -> Void = { (_) in }

    private var observers = [GameEngineObserver]()

    init() {
        let player1 = PlayerEntity("Test player 1")
        let player2 = PlayerEntity("Test player 2")
        game = GameEntity(player1: player1, player2: player2)
    }

    func simulateGameUpdate(_ game: GameEntity) {
        self.game = game
        observers.forEach { $0.gameEngine(self, gameDidUpdate: game) }
    }
}

extension GameEngineMock: GameEngineProtocol {

    var players: [PlayerEntity] {
        return [game.player1, game.player2]
    }

    func add(observer: GameEngineObserver) {
        observers.append(observer)
    }

    func remove(observer: GameEngineObserver) {
        observers.removeAll(where: { $0 === observer })
    }

    func addPointWin(for player: PlayerEntity) {
        addPointWinCallback(player)
    }
}

fileprivate final class GameEngineFactoryMock {
    var gameEngineMock: GameEngineMock

    init(_ engineMock: GameEngineMock = GameEngineMock()) {
        self.gameEngineMock = engineMock
    }
}

extension GameEngineFactoryMock: GameEngineFactoryProtocol {
    func createEngine(player1: PlayerEntity, player2: PlayerEntity) -> GameEngineProtocol {
        return gameEngineMock
    }
}
