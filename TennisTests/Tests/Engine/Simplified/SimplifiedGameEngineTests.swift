//
//  SimplifiedGameEngineTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import XCTest
@testable import Tennis

final class SimplifiedGameEngineTests: XCTestCase {

    private var player1: PlayerEntity!
    private var player2: PlayerEntity!
    private var observer: GameEngineObserverMock!
    private var sut: SimplifiedGameEngine!

    override func setUp() {
        super.setUp()

        player1 = PlayerEntity("Player 1")
        player2 = PlayerEntity("Player 2")
        observer = GameEngineObserverMock()
        sut = SimplifiedGameEngine(player1: player1, player2: player2)
    }

    // MARK: - Test add(observer:) method
    func test_addObserver_1PointChangeNotifiesObserver() {
        // Given
        var receivedGame: GameEntity?
        observer.gameDidUpdateImpl = { (updatedGame) in
            receivedGame = updatedGame
        }

        // When
        sut.add(observer: observer)
        sut.addPointWin(for: player1)

        // Then
        var expectedGame = GameEntity(player1: player1, player2: player2)
        expectedGame.player1Points = 1
        expectedGame.player2Points = 0
        XCTAssertEqual(expectedGame, receivedGame)
    }

    func test_addObserver_2PointChangeNotifiesTwiceObserver() {
        // Given
        var countCalls = 0
        observer.gameDidUpdateImpl = { (_) in
            countCalls += 1
        }

        // When
        sut.add(observer: observer)
        sut.addPointWin(for: player1)
        sut.addPointWin(for: player2)

        // Then
        XCTAssertEqual(countCalls, 2)
    }

    func test_removeObserver_1PointChangeDoesntNotifyObserver() {
        // Given
        var countCalls = 0
        observer.gameDidUpdateImpl = { (_) in
            countCalls += 1
        }

        // When
        sut.add(observer: observer)
        sut.remove(observer: observer)
        sut.addPointWin(for: player2)

        // Then
        XCTAssertEqual(countCalls, 0)
    }
}

fileprivate final class GameEngineObserverMock {
    var gameDidUpdateImpl: (GameEntity) -> Void = { (_) in }
}

extension GameEngineObserverMock: GameEngineObserver {
    func gameEngine(_ engine: GameEngineProtocol, gameDidUpdate game: GameEntity) {
        gameDidUpdateImpl(game)
    }
}
