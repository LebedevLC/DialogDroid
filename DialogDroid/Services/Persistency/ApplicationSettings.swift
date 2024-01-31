//
//  ApplicationSettings.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 31.01.2024.
//

import Foundation

protocol ApplicationSettings: AnyObject {
    var isMusicOn: Bool { get set }
    var selectedMusicIndex: Int { get set }
    
}
