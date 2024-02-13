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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfLaunchBefore()
        setupLabels()
//        test()
    }
    
//    func test() {
//        let text1 = """
//Сообщается, что в некоторых случаях экран часов может произвольно дёргаться, активировать нажатия в случайном месте и вообще всячески мешать пользователю.
//В Apple уведомили СЦ, что проблема на стороне софта и в ближайшем обновлении её должны пофиксить. Так что такие устройства временно не принимаются для обмена или ремонта.
//"""
//        let text2 = "Hello world"
//        let db = servicesProvider.coreDataManager
//        try? db.saveChatMessage(
//            MessageModel(
//                isFromUser: true,
//                message: text1,
//                timestamp: Date()
//            )
//        )
//        try? db.saveChatMessage(
//            MessageModel(
//                isFromUser: true,
//                message: text2,
//                timestamp: Date()
//            )
//        )
//        try? db.saveChatMessage(
//            MessageModel(
//                isFromUser: false,
//                message: text1,
//                timestamp: Date()
//            )
//        )
//        try? db.saveChatMessage(
//            MessageModel(
//                isFromUser: false,
//                message: text2,
//                timestamp: Date()
//            )
//        )
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
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
    
    // MARK: - Public Methods
    
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
