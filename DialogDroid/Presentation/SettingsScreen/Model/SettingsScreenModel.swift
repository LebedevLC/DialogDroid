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
        switch self {
        case .music:
            return R.string.localizable.settingsMusicItem()
        case .deleteChatHistory:
            return R.string.localizable.settingsDeleteChatItem()
        case .about:
            return R.string.localizable.settingsAboutItem()
        }
    }
}
