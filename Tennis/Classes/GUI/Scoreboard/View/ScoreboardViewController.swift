//
//  ScoreboardViewController.swift
//  Tennis
//
//  Created by 2019_DEV_102 on 2/17/19.
//  Copyright © 2019 2019_DEV_102. All rights reserved.
//

import UIKit

/// Displays a tennis scoring board.
final class ScoreboardViewController: UIViewController {

    /// Presenter for this screen.
    /// Must be set before the view loads.
    var viewModel: ScoreboardViewModel!

    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var simulateWinningStackView: UIStackView!
    @IBOutlet weak var resetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        apply(presentationModel: viewModel.presentationModel)
        viewModel.presentationModelDidChange = {[weak self] (newModel) in
            self?.apply(presentationModel: newModel)
        }
    }

    @IBAction func didTapAddPointToPlayer1() {
        viewModel.addPointWinForPlayer1()
    }

    @IBAction func didTapAddPointToPlayer2() {
        viewModel.addPointWinForPlayer2()
    }

    @IBAction func didTapReset() {
        viewModel.reset()
    }

    private func apply(presentationModel: ScoreboardPresentationModel) {
        player1NameLabel.text = presentationModel.player1Name
        player2NameLabel.text = presentationModel.player2Name
        scoreLabel.text = presentationModel.score
        simulateWinningStackView.isHidden = presentationModel.isFinished == true
        resetButton.isHidden = presentationModel.isFinished == false
    }
}
