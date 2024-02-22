//
//  ChatRole.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 17.02.2024.
//

import Foundation

enum ChatRole: Int, CaseIterable {
    case dialog
    case teacher
    case friend
    case lover
    
    var title: String {
        switch self {
        case .dialog:
            return R.string.localizable.chatRoleTitleDialog()
        case .teacher:
            return R.string.localizable.chatRoleTitleTeacher()
        case .friend:
            return R.string.localizable.chatRoleTitleFriend()
        case .lover:
            return R.string.localizable.chatRoleTitleLover()
        }
    }
    
    var shortTitle: String {
        switch self {
        case .dialog:
            return R.string.localizable.chatRoleShortTitleDialog()
        case .teacher:
            return R.string.localizable.chatRoleShortTitleTeacher()
        case .friend:
            return R.string.localizable.chatRoleShortTitleFriend()
        case .lover:
            return R.string.localizable.chatRoleShortTitleLover()
        }
    }
    
    var description: String {
        switch self {
        case .dialog:
            return R.string.localizable.chatRoleDescriptionDialog()
        case .teacher:
            return R.string.localizable.chatRoleDescriptionTeacher()
        case .friend:
            return R.string.localizable.chatRoleDescriptionFriend()
        case .lover:
            return R.string.localizable.chatRoleDescriptionLover()
        }
    }
    
    var promptAI: String {
        switch self {
        case .dialog:
            return R.string.notLocalizable.promptDialog()
        case .teacher:
            return R.string.notLocalizable.promptTeacher()
        case .friend:
            return R.string.notLocalizable.promptFriend()
        case .lover:
            return R.string.notLocalizable.promptLover()
        }
    }
}
