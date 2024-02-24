//
//  LaunchScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 24.02.2024.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var animationCompletion: (() -> Void)?
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var animationContainerView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: 0.3,
            delay: 2,
            options: []
        ) {
            // test
            self.animationContainerView.backgroundColor = .white
        } completion: { [weak self] _ in
            UIView.animate(
                withDuration: 1
            ) {
                self?.view.alpha = 0
            } completion: { _ in
                self?.animationCompletion?()
            }
        }
    }
}
