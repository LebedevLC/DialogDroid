//
//  AIClientCommand.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 20.02.2024.
//

import Foundation

final class AIClientCommand: Encodable {
    
    // MARK: - Private Properties
    
    private var model: String
    private var messages: [AIClientCommandMessage]
    
    // MARK: - Initialization
    
    init(model: String, message: String) {
        self.model = model
        self.messages = [AIClientCommandMessage(role: "user", content: message)]
    }
}

struct AIClientCommandMessage: Encodable {
    var role: String
    var content: String
}
