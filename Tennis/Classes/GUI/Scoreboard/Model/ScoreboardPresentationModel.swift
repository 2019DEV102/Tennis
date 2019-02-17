//
//  ScoreboardPresentationModel.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.

import Foundation

/// Presentation model for Scoreboard screen.
struct ScoreboardPresentationModel {
    /// The name of the first player.
    var player1Name = ""
    /// The name of the second player.
    var player2Name = ""
    /// The tennis score(0, 15, 30, 40, deuce, advantage, player won)
    var score = ""
    /// Flag to indicate if the game has finished.
    var isFinished = false
}

extension ScoreboardPresentationModel: Equatable {}
