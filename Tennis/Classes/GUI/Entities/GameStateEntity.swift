//
//  GameStateEntity.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// A tennis game state value.
enum GameStateEntity {
    /// Represents an active game that has not finished.
    case playing
    /// Represents an finished game. Holds the winning player.
    case finished(PlayerEntity)
}

extension GameStateEntity: Equatable {}
