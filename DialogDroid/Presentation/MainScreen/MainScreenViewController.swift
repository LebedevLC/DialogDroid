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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - Actions
    
    @IBAction private func settingsButtonDidTap(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    @IBAction private func shareButtonDidTap(_ sender: Any) {
        print(#function)
    }
    
    @IBAction private func rolePlayChatButtonDidTap(_ sender: Any) {
        print(#function)
    }
    
    @IBAction private func plainChatButtonDidTap(_ sender: Any) {
        print(#function)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        #warning("Localization")
        navigationItem.title = "Main Screen"
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
