//
//  LaunchScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 24.02.2024.
//

import Lottie
import UIKit

final class LaunchScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var animationCompletion: (() -> Void)?
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var animationContainerView: UIView!
    
    private lazy var animatedLogo = {
        let view = LottieAnimationView()
        view.animation = .named("Animation1")
        view.loopMode = .loop
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedLogo.play()
        UIView.animate(
            withDuration: 0.5
        ) {
            self.animatedLogo.alpha = 1
        } completion: { [weak self] _ in
            UIView.animate(
                withDuration: 1,
                delay: 3
            ) {
                self?.view.alpha = 0
            } completion: { _ in
                self?.animationCompletion?()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupLogoView() {
        view.addSubview(animatedLogo)
        NSLayoutConstraint.activate([
            animatedLogo.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor),
            animatedLogo.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor),
            animatedLogo.topAnchor.constraint(equalTo: animationContainerView.topAnchor),
            animatedLogo.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor)
        ])
    }
}
