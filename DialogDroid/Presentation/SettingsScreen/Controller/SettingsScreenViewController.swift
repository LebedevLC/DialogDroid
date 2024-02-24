//
//  SettingsScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 26.01.2024.
//

import UIKit

final class SettingsScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let screenModel = SettingsScreenCollectionModel.allCases
    private let servicesProvider: ServicesProvider = DefaultServicesProvider.shared
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - Actions
    
    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.title = R.string.localizable.settingsScreenTitle()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "SettingsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SettingsCollectionViewCell"
        )
    }
    
    private func presentDeleteAllMessagesAlert(deleteHandler: @escaping () -> Void ) {
        let cancelAction = UIAlertAction(
            title: R.string.localizable.alertCancel(),
            style: .cancel
        )
        let deleteAction = UIAlertAction(
            title: R.string.localizable.alertDelete(),
            style: .destructive
        ) { _ in deleteHandler() }
        let actions = [cancelAction, deleteAction]
        let alertController = UIAlertController(
            title: R.string.localizable.settingsScreenDeleteAllMessagesTitle(),
            message: R.string.localizable.settingsScreenDeleteAllMessagesMessage(),
            preferredStyle: .alert
        )
        actions.forEach({ alertController.addAction($0) })
        present(alertController, animated: true)
    }
    
    private func presentAboutAlert() {
        let alertController = UIAlertController(
            title: "About the application",
            message: "DialogDroid\nCreated by Sergey Chumovskikh in 2024",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SettingsCollectionViewCell",
            for: indexPath
        ) as? SettingsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(from: screenModel[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SettingsScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt ", screenModel[indexPath.item])
        switch screenModel[indexPath.item] {
        case .music:
            performSegue(withIdentifier: "goToMusicSettings", sender: nil)
        case .deleteChatHistory:
            presentDeleteAllMessagesAlert { [weak self] in
                do {
                    try self?.servicesProvider.coreDataManager.deleteAllMessages()
                    let result = try self?.servicesProvider.coreDataManager.getAllChatMessages()
                } catch {
                    print(error)
                }
            }
        case .about:
            presentAboutAlert()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SettingsScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 80)
    }
}
