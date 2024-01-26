//
//  SettingsScreenModel.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 26.01.2024.
//

import Foundation

enum SettingsScreenCollectionModel: CaseIterable {
    case music
    case deleteChatHistory
    case about
    
    var title: String {
        #warning("Localization")
        switch self {
        case .music:
            return "Music"
        case .deleteChatHistory:
            return "Delete all chat history"
        case .about:
            return "About application"
        }
    }
}
