//
//  AIManager.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 22.02.2024.
//

import Foundation

protocol AIManager: AnyObject {
    func getDialogueResponse(
        _ messages: [MessageModel],
        role: ChatRole,
        completion: @escaping (Result<String, AIClientError>) -> Void
    )
}

final class DefaultAIManager: AIManager {
    
    // MARK: - Private Properties
    
    private let client: AIClient
    
    // MARK: - Initialization
    
    init(client: AIClient) {
        self.client = client
    }
    
    // MARK: - Public Methods
    
    func getDialogueResponse(
        _ messages: [MessageModel],
        role: ChatRole,
        completion: @escaping (Result<String, AIClientError>) -> Void
    ) {
        let context = calculateContext(messages, role: role)
        
        client.sendCompletion(
            with: context,
            model: .gpt35Turbo,
            completionHandler: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let model):
                    let answer = model.choices.first?.message.content ?? "?"
                    completion(.success(answer))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    // MARK: - Private Methods
    
    private func calculateContext(_ messages: [MessageModel], role: ChatRole) -> String {
        var context = role.promptAI
        var messagesContext = String()
        
        let lastMessagesCount: Int = 5
        let lastMessages: [MessageModel]
        
        if messages.count >= lastMessagesCount {
            lastMessages = Array(messages.dropFirst(messages.count - lastMessagesCount))
        } else {
            lastMessages = messages
        }
        
        lastMessages.forEach({ message in
            if message.isFromUser {
                let humanResponse = "Human: \(message.message)\n"
                messagesContext += humanResponse
            } else {
                let aiResponse = "AI: \(message.message)\n"
                messagesContext += aiResponse
            }
        })
        messagesContext += "AI: "
        context += messagesContext
        return context
    }
}
