//
//  UIView.AnimationOptions+Extensions.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 16.02.2024.
//

import UIKit

extension UIView.AnimationOptions {
    
    init(curve: UIView.AnimationCurve) {
        switch curve {
        case .easeInOut:
            self = .curveEaseOut
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .linear:
            self = .curveLinear
        @unknown default:
            self = .curveEaseInOut
        }
    }
}
