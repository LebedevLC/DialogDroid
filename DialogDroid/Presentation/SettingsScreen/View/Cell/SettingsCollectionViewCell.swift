//
//  SettingsCollectionViewCell.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 26.01.2024.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties

    @IBOutlet private weak var cellBackgroundView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.layer.masksToBounds = true
    }
    
    // MARK: - Public Methods
    
    func configure(from model: SettingsScreenCollectionModel) {
        titleLabel.text = model.title
    }
    
    // MARK: - Actions

    @IBAction private func nextButtonDidTap(_ sender: Any) {
        
    }
    
    // MARK: - Private Methods
}
