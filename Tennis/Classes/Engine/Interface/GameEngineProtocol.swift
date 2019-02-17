//
//  GameEngineProtocol.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Definition for an game engine.
/// Common behavior for different types of games.
protocol GameEngineProtocol: AnyObject {
    /// The model of the game.
    var game: GameEntity {get}
    /// Players part of the game.
    var players: [PlayerEntity] {get}

    /// Register for game model changes.
    /// - Parameter observer: Object to register.
    func add(observer: GameEngineObserver)
    /// Unregister for game model changes.
    /// - Parameter observer: Object to unregister.
    func remove(observer: GameEngineObserver)

    /// Simulate a point win for a given player.
    /// - Parameter player: Player who won the point.
    func addPointWin(for player: PlayerEntity)
}
