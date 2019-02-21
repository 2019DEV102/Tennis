//
//  GameEntityTests.swift
//  TennisTests
//
//  Created by 2019_DEV_102 on 2/21/19.
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

    func test_player1Wins() {
        // When
        for _ in 0..<4 {
            sut.addPointWin(for: sut.player1)
        }

        // Then
        XCTAssertEqual("Game won by Player 1", sut.displayedScore)
    }

    func test_player2Wins() {
        // When
        for _ in 0..<4 {
            sut.addPointWin(for: sut.player2)
        }

        // Then
        XCTAssertEqual("Game won by Player 2", sut.displayedScore)
    }
    
    func test_deuce() {
        // When
        for _ in 0..<4 {
            sut.addPointWin(for: sut.player1)
            sut.addPointWin(for: sut.player2)
        }

        // Then
        XCTAssertEqual("Deuce", sut.displayedScore)
    }
}
