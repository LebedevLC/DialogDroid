//
//  MusicSettingsCollectionViewCell.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 30.01.2024.
//

import UIKit

final class MusicSettingsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Overriding Properties
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState(isSelected: isSelected)
        }
    }
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var checkBoxImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cellBackgroundView: UIView!
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 24
        layer.cornerCurve = .continuous
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    // MARK: - Public Methods
    
    func configure(with model: MusicCollection) {
        titleLabel.text = model.title
    }
    
    // MARK: - Private Methods
    
    private func updateSelectedState(isSelected: Bool) {
        UIView.transition(
            with: checkBoxImageView,
            duration: 0.3,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {
                self.checkBoxImageView.image = isSelected ?
                UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            }
        )
    }
}
