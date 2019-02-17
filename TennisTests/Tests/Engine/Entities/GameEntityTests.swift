//
//  GameEntityTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import XCTest
@testable import Tennis

final class GameEntityTests: XCTestCase {

    private var sut: GameEntity!

    override func setUp() {
        super.setUp()

        let player1 = PlayerEntity("Player 1")
        let player2 = PlayerEntity("Player 2")
        sut = GameEntity(player1: player1, player2: player2)
    }

    // MARK: - Test state updates
    func test_state_playingPlayer1OnePoint() {
        // When
        sut.player1Points = 1
        sut.player2Points = 0

        // Then
        XCTAssertEqual(GameStateEntity.playing, sut.state)
    }

    func test_state_playingPlayer1ThreePoints() {
        // When
        sut.player1Points = 3
        sut.player2Points = 0

        // Then
        XCTAssertEqual(GameStateEntity.playing, sut.state)
    }

    func test_state_playingPlayer1Player2FourPoints() {
        // When
        sut.player1Points = 4
        sut.player2Points = 4

        // Then
        XCTAssertEqual(GameStateEntity.playing, sut.state)
    }

    func test_state_playingPlayer1FourPointsPlayer2FivePoints() {
        // When
        sut.player1Points = 4
        sut.player2Points = 5

        // Then
        XCTAssertEqual(GameStateEntity.playing, sut.state)
    }

    func test_state_finishedPlayer2FourPoints() {
        // When
        sut.player1Points = 0
        sut.player2Points = 4

        // Then
        let expectedState = GameStateEntity.finished(sut.player2)
        XCTAssertEqual(expectedState, sut.state)
    }

    func test_state_finishedPlayer1SixPointsPlayer2FourPoints() {
        // When
        sut.player1Points = 6
        sut.player2Points = 4

        // Then
        let expectedState = GameStateEntity.finished(sut.player1)
        XCTAssertEqual(expectedState, sut.state)
    }

}
