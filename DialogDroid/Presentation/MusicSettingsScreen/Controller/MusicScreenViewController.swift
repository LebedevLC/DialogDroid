//
//  MusicScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 30.01.2024.
//

import UIKit

final class MusicScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var enableMusicSwitch: UISwitch!
    @IBOutlet private weak var enableMusicLabel: UILabel!
    
    private var selectedIndex: IndexPath?
    private let musicModel: [MusicCollection] = MusicCollection.allCases
    
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
    
    @IBAction private func switchValueDidChange(_ sender: UISwitch) {
        print(#function)
    }
    
    // MARK: - Private Methods
    
    private func selectCurrentMusic(_ music: MusicCollection) {
        print(#function)
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "MusicSettingsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MusicSettingsCollectionViewCell"
        )
    }
    
    private func configureNavigationBar() {
        #warning("Localization")
        navigationItem.title = "Music settings"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
    }
}

// MARK: - UICollectionViewDataSource

extension MusicScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MusicSettingsCollectionViewCell",
            for: indexPath
        ) as? MusicSettingsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: musicModel[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MusicScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex {
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        selectedIndex = indexPath
        selectCurrentMusic(musicModel[indexPath.item])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MusicScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}
