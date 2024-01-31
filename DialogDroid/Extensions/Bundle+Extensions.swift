//
//  Bundle+Extensions.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 31.01.2024.
//

import Foundation

extension Bundle {
    static var mainBundleIdentifier: String {
        return main.bundleIdentifier ?? "DialogDroid"
    }
}
