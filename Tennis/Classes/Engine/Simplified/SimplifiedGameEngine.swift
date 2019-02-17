//
//  SimplifiedGameEngine.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Implementation of a simplified game engine.
final class SimplifiedGameEngine {

    /// First player.
    let player1: PlayerEntity
    /// Second player
    let player2: PlayerEntity

    /// The game model.
    private(set) var game: GameEntity {
        didSet {
            gameDidChange()
        }
    }
    private var observers = [ObjectIdentifier: WeakObserver]()

    /// Construct a game engine.
    /// - Parameter player1: First player.
    /// - Parameter player2: Second player.
    init(player1: PlayerEntity, player2: PlayerEntity) {
        self.player1 = player1
        self.player2 = player2
        game = GameEntity(player1: player1, player2: player2)
    }

    private func gameDidChange() {
        observers.forEach { (pair) in
            pair.value.value?.gameEngine(self, gameDidUpdate: game)
        }
    }
}

extension SimplifiedGameEngine: GameEngineProtocol {
    var players: [PlayerEntity] {
        return [player1, player2]
    }

    func add(observer: GameEngineObserver) {
        let identifier = ObjectIdentifier(observer)
        observers[identifier] = WeakObserver(observer)
    }

    func remove(observer: GameEngineObserver) {
        let identifier = ObjectIdentifier(observer)
        observers.removeValue(forKey: identifier)
    }

    func addPointWin(for player: PlayerEntity) {
        guard case .playing = game.state else {
            fatalError("Can't add a point win to a finished game")
        }

        switch player {
        case player1:
            game.player1Points += 1
        case player2:
            game.player2Points += 1
        default:
            fatalError("Player \(player) is not part of this game: \(self)")
        }
    }
}

fileprivate final class WeakObserver {
    weak var value: GameEngineObserver?

    init(_ value: GameEngineObserver) {
        self.value = value
    }
}