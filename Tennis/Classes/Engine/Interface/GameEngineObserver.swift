//
//  GameEngineObserver.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Definies a game model observer.
protocol GameEngineObserver: AnyObject {
    /// Notifition triggered when the game model changes.
    /// - Parameter engine: The game engine that triggered the notification.
    /// - Parameter game: The updated model.
    func gameEngine(_ engine: GameEngineProtocol, gameDidUpdate game: GameEntity)
}
