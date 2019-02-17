//
//  ScoreboardPresentationModelFactoryTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import XCTest
@testable import Tennis

final class ScoreboardPresentationModelFactoryTests: XCTestCase {

    private var sut: ScoreboardPresentationModelFactory!
    private var game: GameEntity!

    override func setUp() {
        super.setUp()

        sut = ScoreboardPresentationModelFactory()
        let player1 = PlayerEntity("Test player 1")
        let player2 = PlayerEntity("Test player 2")
        game = GameEntity(player1: player1, player2: player2)
    }

    // MARK: - Test createPresentationModel(from, player1, player2) method
    func test_createPresentationModel_playingStateDisplays30_0() {
        // Given
        game.player1Points = 2

        // When
        let presentationModel = sut.createPresentationModel(from: game)

        // Then
        XCTAssertEqual(presentationModel.player1Name, game.player1.name)
        XCTAssertEqual(presentationModel.player2Name, game.player2.name)
        XCTAssertEqual(presentationModel.score, "30 - 0")
        XCTAssertFalse(presentationModel.isFinished)
    }

    func test_createPresentationModel_playingStateDisplays15_15() {
        // Given
        game.player1Points = 1
        game.player2Points = 1

        // When
        let presentationModel = sut.createPresentationModel(from: game)

        // Then
        XCTAssertEqual(presentationModel.score, "15 - 15")
        XCTAssertFalse(presentationModel.isFinished)
    }

    func test_createPresentationModel_playingStateDisplaysDeuce() {
        // Given
        game.player1Points = 3
        game.player2Points = 3

        // When
        let presentationModel = sut.createPresentationModel(from: game)

        // Then
        XCTAssertEqual(presentationModel.score, "Deuce")
        XCTAssertFalse(presentationModel.isFinished)
    }

    func test_createPresentationModel_playingStateDisplaysAdvantagePlayer2() {
        // Given
        game.player1Points = 4
        game.player2Points = 5

        // When
        let presentationModel = sut.createPresentationModel(from: game)

        // Then
        XCTAssertEqual(presentationModel.score, "Advantage for \(game.player2.name)")
        XCTAssertFalse(presentationModel.isFinished)
    }

    func test_createPresentationModel_displaysPlayer1Won() {
        // Given
        game.player1Points = GameEntity.minTotalPointsToWin

        // When
        let presentationModel = sut.createPresentationModel(from: game)

        // Then
        XCTAssertEqual(presentationModel.score, "Game won by \(game.player1.name)")
        XCTAssertTrue(presentationModel.isFinished)
    }
}
