//
//  ApplicationStorage.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 31.01.2024.
//

import Foundation

protocol ApplicationStorage: AnyObject {
    var isLaunchedBefore: Bool { get set }
}
