//
//  RoleScreenTableViewCell.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 17.02.2024.
//

import UIKit

class RoleScreenTableViewCell: UITableViewCell {
    
    // MARK: - OverridingProperties
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState(isSelected: isSelected)
        }
    }
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var cellBackgroundView: UIView!
    @IBOutlet private weak var cellTitleLabel: UILabel!
    @IBOutlet private weak var cellDescriptionLabel: UILabel!
    @IBOutlet private weak var cellImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellBackgroundView.layer.masksToBounds = true
        cellBackgroundView.layer.cornerCurve = .continuous
        cellBackgroundView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellDescriptionLabel.text = nil
        cellTitleLabel.text = nil
    }
    
    // MARK: - Public Methods
    
    func configure(title: String, description: String) {
        cellDescriptionLabel.text = description
        cellTitleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func updateSelectedState(isSelected: Bool) {
        UIView.transition(
            with: cellImageView,
            duration: 0.3,
            options: [.transitionCrossDissolve, .curveEaseInOut],
            animations: {
                self.cellImageView.image = isSelected ?
                UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            }
        )
    }
}
