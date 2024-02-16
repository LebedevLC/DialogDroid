//
//  Notification+Extensions.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 16.02.2024.
//

import UIKit

extension Notification {
    struct KeyboardAnimationInfo {
        var height: CGFloat
        var duration: TimeInterval
        var options: UIView.AnimationOptions
    }
    
    var keyboardAnimationInfo: KeyboardAnimationInfo? {
        guard
            let userInfo = userInfo,
            let boundsValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let timing = UIView.AnimationCurve.RawValue(exactly: curveNumber),
            let animationCurve = UIView.AnimationCurve(rawValue: timing)
        else {
            return nil
        }
        
        return KeyboardAnimationInfo(
            height: boundsValue.cgRectValue.height,
            duration: durationNumber.doubleValue,
            options: UIView.AnimationOptions(curve: animationCurve)
        )
    }
}
