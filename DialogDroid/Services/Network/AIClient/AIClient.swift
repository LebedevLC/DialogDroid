//
//  AIClient.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 20.02.2024.
//

import Alamofire

enum AIClientError: Error {
    case genericError(Error)
    case decodingError(Error)
}

protocol AIClient: AnyObject {
    func sendCompletion(
        with prompt: String,
        model: AIClientModelType,
        completionHandler: @escaping (Result<AIClientModel, AIClientError>) -> Void
    )
}

final class DefaultAIClient: AIClient {
    
    // MARK: - Private Properties
    
    private let token: String
    
    // MARK: - Initialization
    
    init(token: String) {
        self.token = token
    }
    
    // MARK: - Public Methods
    
    func sendCompletion(
        with prompt: String,
        model: AIClientModelType,
        completionHandler: @escaping (Result<AIClientModel, AIClientError>) -> Void
    ) {
        let endpoint = AIClientEndpoint.completions
        let body = AIClientCommand(model: model.modelName, message: prompt)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(
            endpoint.baseURL + endpoint.path,
            method: HTTPMethod(rawValue: endpoint.method),
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: AIClientModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(.success(result))
            case .failure(let error):
                if let decodingError = error.underlyingError as? DecodingError {
                    completionHandler(.failure(.decodingError(decodingError)))
                } else {
                    completionHandler(.failure(.genericError(error)))
                }
            }
        }
    }
}
