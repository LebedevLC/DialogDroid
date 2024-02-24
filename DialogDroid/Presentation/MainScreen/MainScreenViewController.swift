//
//  MainScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 25.01.2024.
//

import UIKit

class MainScreenViewController: UIViewController {

    // MARK: - Private Properties
    
    @IBOutlet private weak var animatedViewContainer: UIView!
    @IBOutlet private weak var centerLabel: UILabel!
    
    private let servicesProvider: ServicesProvider = DefaultServicesProvider.shared
    private var isNeedShowSplashScreen: Bool = true
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfLaunchBefore()
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        showSplashScreen()
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
    
    @IBAction private func rolePlayChatButtonDidTap(_ sender: Any) {
        print(#function)
    }
    
    @IBAction private func plainChatButtonDidTap(_ sender: Any) {
        performSegue(withIdentifier: "goToPlainChat", sender: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupLabels() {
        centerLabel.text = R.string.localizable.mainScreenCenterLabel()
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
}

// MARK: - Segue

extension MainScreenViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToSettings":
            guard let destinationController = segue.destination as? SettingsScreenViewController else { return }
            // some data
            //destinationController
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
}
