//
//  AIClientEndpoint.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 20.02.2024.
//

import Foundation

enum AIClientEndpoint {
    case completions
    
    var path: String {
        switch self {
        case .completions:
            return "/v1/chat/completions"
        }
    }
    
    var method: String {
        switch self {
        case .completions:
            return "POST"
        }
    }
    
    var baseURL: String {
        switch self {
        case .completions:
            return "https://api.openai.com"
        }
    }
}
