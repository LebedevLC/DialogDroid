//
//  MusicScreenModel.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 30.01.2024.
//

import Foundation

enum MusicCollection: CaseIterable {
    case music1
    case music2
    case music3
    case music4
    case music5
    case music6
    case music7
    
    #warning("Localization")
    var title: String {
        switch self {
        case .music1:
            "Soft music"
        case .music2:
            "Rock music"
        case .music3:
            "Electro music"
        case .music4:
            "Techno music"
        case .music5:
            "Jazz music"
        case .music6:
            "Pop music"
        case .music7:
            "Light beat music"
        }
    }
    
    var fileUrl: URL? {
        switch self {
        default:
            return nil
        }
    }
}
