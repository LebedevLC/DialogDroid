//
//  AIClientModelType.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 20.02.2024.
//

import Foundation

/// Модель бота
enum AIClientModelType {
    case gpt35Turbo
    
    var modelName: String {
        switch self {
        case .gpt35Turbo:
            return "gpt-3.5-turbo-0613"
        }
    }
}
