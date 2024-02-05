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
    
    var title: String {
        switch self {
        case .music1:
            R.string.localizable.musicCollectionItemSoft()
        case .music2:
            R.string.localizable.musicCollectionItemRock()
        case .music3:
            R.string.localizable.musicCollectionItemElectro()
        case .music4:
            R.string.localizable.musicCollectionItemTechno()
        case .music5:
            R.string.localizable.musicCollectionItemJazz()
        case .music6:
            R.string.localizable.musicCollectionItemPop()
        case .music7:
            R.string.localizable.musicCollectionItemLight()
        }
    }
    
    var fileUrl: URL? {
        switch self {
        default:
            return nil
        }
    }
}
