//
//  CoreDataManager.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 07.02.2024.
//

import CoreData

protocol CoreDataManager {
    func getAllChatMessages() throws -> [MessageModel]
    func saveChatMessage(_ model: MessageModel) throws -> Bool
}

final class DefaultCoreDataManager: CoreDataManager {
    
    // MARK: - Private Properties
    
    private let database: CoreDataService
    
    // MARK: - Initialization
    
    init(database: CoreDataService) {
        self.database = database
    }
    
    // MARK: - Public Methods
    
    func getAllChatMessages() throws -> [MessageModel] {
        let key = #keyPath(CoreDataChatMessage.timestamp)
        let sortByDate = NSSortDescriptor(key: key, ascending: false)
        let coreDataChatMessage = try database.fetchObjects(ofType: CoreDataChatMessage.self, sortBy: [sortByDate])
        return coreDataChatMessage.compactMap({ MessageModel(from: $0) })
    }
    
    func saveChatMessage(_ model: MessageModel) throws -> Bool {
        let coreDataChatMessage = try database.createObject(from: CoreDataChatMessage.self)
        coreDataChatMessage.populate(from: model)
        return try database.saveChanges()
    }
}
