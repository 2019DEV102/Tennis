//
//  ScoreboardViewModelTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import XCTest
@testable import Tennis

final class ScoreboardViewModelTests: XCTestCase {

    private var sut: ScoreboardViewModel!

    override func setUp() {
        super.setUp()
        let player1 = PlayerEntity("Player 1")
        let player2 = PlayerEntity("Player 2")
        sut = ScoreboardViewModel(player1: player1, player2: player2)
    }

    // MARK: - Test addPointWinForPlayer1 method
    func test_addPointWinForPlayer1() {
        // When
        sut.addPointWinForPlayer1()

        // Then
        XCTAssertEqual("15 - 0", sut.presentationModel.score)
    }

    // MARK: - Test addPointWinForPlayer2 method
    func test_addPointWinForPlayer2() {
        // When
        sut.addPointWinForPlayer2()

        // Then
        XCTAssertEqual("0 - 15", sut.presentationModel.score)
    }
}
