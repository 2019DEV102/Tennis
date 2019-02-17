//
//  PlayerEntity.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// A tennis player value.
struct PlayerEntity {
    /// The name of the player.
    let name: String
    /// An unique identifier for the player.
    let identifier: UUID

    /// Construct a player with a given name and unique identifier.
    /// - Parameter name: Provided name.
    /// - Parameter identifier: Provided identifier.
    init(_ name: String, identifier: UUID = UUID()) {
        self.name = name
        self.identifier = identifier
    }
}

extension PlayerEntity: Equatable {}
