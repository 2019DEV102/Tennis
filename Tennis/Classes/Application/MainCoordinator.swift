//
//  MainCoordinator.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import UIKit

/// Application's main coordination.
/// Creates and set ups the main window.
final class MainCoordinator {

    private let window: UIWindow
    private let gameEngineFactory = SimplifiedGameEngineFactory()

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        loadInitialScreen()
    }

    /// Load the Scoreboard screen.
    func loadInitialScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! ScoreboardViewController

        let player1 = PlayerEntity("Player 1")
        let player2 = PlayerEntity("Player 2")
        let viewModel = ScoreboardViewModel(gameEngineFactory: gameEngineFactory,
                                            player1: player1,
                                            player2: player2)
        viewController.viewModel = viewModel

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
