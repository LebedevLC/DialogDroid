//
//  MainScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 25.01.2024.
//

import Lottie
import UIKit

class MainScreenViewController: UIViewController {

    // MARK: - Private Properties
    
    @IBOutlet private weak var animatedViewContainer: UIView!
    @IBOutlet private weak var centerLabel: UILabel!
    @IBOutlet private weak var goToChatView: CornerView!
    @IBOutlet private weak var goToChatLabel: UILabel!
    
    private lazy var animatedLogo = {
        let view = LottieAnimationView()
        view.animation = .named("Animation2")
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let servicesProvider: ServicesProvider = DefaultServicesProvider.shared
    private var isNeedShowSplashScreen: Bool = true
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoView()
        checkIfLaunchBefore()
        setupLabels()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        showSplashScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedLogo.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animatedLogo.pause()
    }
    
    // MARK: - Actions
    
    @IBAction private func settingsButtonDidTap(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    @IBAction private func shareButtonDidTap(_ sender: Any) {
        guard let url = URL(string: "https://apple.com") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    @objc private func chatButtonDidTap() {
        UIView.animate(withDuration: 0.1) { [self] in
            goToChatLabel.transform = goToChatLabel.transform.scaledBy(x: 0.9, y: 0.9)
        } completion: { _ in
            self.goToChatLabel.transform = .identity
            self.performSegue(withIdentifier: "goToPlainChat", sender: nil)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupGestures() {
        goToChatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chatButtonDidTap)))
    }
    
    private func setupLabels() {
        centerLabel.text = R.string.localizable.mainScreenCenterLabel()
        goToChatLabel.text = R.string.localizable.mainScreenGoToChatLabel()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = R.string.localizable.mainScreenTitle()
    }
    
    private func checkIfLaunchBefore() {
        if !servicesProvider.applicationStorage.isLaunchedBefore {
            servicesProvider.applicationStorage.isLaunchedBefore = true
        }
    }
    
    private func showSplashScreen() {
        guard isNeedShowSplashScreen else { return }
        isNeedShowSplashScreen = false
        let storyboard = UIStoryboard(name: R.storyboard.main.name, bundle: nil)
        guard let splashScreenViewController = storyboard.instantiateViewController(
            withIdentifier: "splashVC"
        ) as? LaunchScreenViewController
        else { return }
        splashScreenViewController.animationCompletion = { [weak self] in
            self?.dismiss(animated: false)
        }
        splashScreenViewController.modalPresentationStyle = .fullScreen
        present(splashScreenViewController, animated: false)
    }
    
    private func setupLogoView() {
        view.addSubview(animatedLogo)
        NSLayoutConstraint.activate([
            animatedLogo.leadingAnchor.constraint(equalTo: animatedViewContainer.leadingAnchor),
            animatedLogo.trailingAnchor.constraint(equalTo: animatedViewContainer.trailingAnchor),
            animatedLogo.topAnchor.constraint(equalTo: animatedViewContainer.topAnchor),
            animatedLogo.bottomAnchor.constraint(equalTo: animatedViewContainer.bottomAnchor)
        ])
    }
}
