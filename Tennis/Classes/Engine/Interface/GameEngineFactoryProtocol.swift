//
//  GameEngineFactoryProtocol.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Defines a method for creating an abstract game engine.
protocol GameEngineFactoryProtocol: AnyObject {

    /// Definition for creating a game engine.
    /// - Parameter player1: First player part of the game.
    /// - Parameter player1: First player part of the game.
    /// - Returns: An game engine.
    func createEngine(player1: PlayerEntity, player2: PlayerEntity) -> GameEngineProtocol
}
