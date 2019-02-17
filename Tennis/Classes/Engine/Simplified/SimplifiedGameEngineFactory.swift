//
//  SimplifiedGameEngineFactory.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Factory class for creating a simplified game engine, similar to Wii tennis.
final class SimplifiedGameEngineFactory {}

extension SimplifiedGameEngineFactory: GameEngineFactoryProtocol {
    /// Factory method for creating a simplified game engine.
    /// - Parameter player1: First player part of the game.
    /// - Parameter player1: First player part of the game.
    /// - Returns: The game engine.
    func createEngine(player1: PlayerEntity,
                      player2: PlayerEntity) -> GameEngineProtocol {
        return SimplifiedGameEngine(player1: player1, player2: player2)
    }
}
