//
//  CornerView.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 25.01.2024.
//

import UIKit

final class CornerView: UIView {
    
    // MARK: - Private Properties
    
    private var isShadowConfigured: Bool = false
    private var isCornersConfigured: Bool = false
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isShadowConfigured {
            configureShadow()
            isShadowConfigured = true
        }
        if !isCornersConfigured {
            configureCorners()
            isCornersConfigured = true
        }
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    // MARK: - Private Methods
    
    private func configureShadow() {
        let shadowOpacity: Float = 12.0
        let shadowRadius = 12.0
        let color = UIColor.black.withAlphaComponent(0.45).cgColor
        
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 0, height: -4)
    }
    
    private func configureCorners() {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerCurve = .continuous
        layer.cornerRadius = 8
//        layer.masksToBounds = true
    }
}
