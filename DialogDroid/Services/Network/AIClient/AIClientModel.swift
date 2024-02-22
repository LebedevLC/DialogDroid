//
//  AIClientModel.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 20.02.2024.
//

import Foundation

/// Получаемая от бота сетевая модель
struct AIClientModel: Codable {
    let object: String
    let model: String
    let choices: [AIClientChoice]
}

struct AIClientChoice: Codable {
    let message: AIClientMessage
}

struct AIClientMessage: Codable {
    let content: String
}
