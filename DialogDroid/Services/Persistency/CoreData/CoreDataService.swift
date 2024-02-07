//
//  CoreDataService.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 07.02.2024.
//

import CoreData
import Foundation

enum CoreDataServiceError: Error {
    case failCastToType(String)
}


final class CoreDataService {
    
    // MARK: - Private Properties
    
    private let persistentStoreContainer: NSPersistentContainer
    private var context: NSManagedObjectContext { persistentStoreContainer.viewContext }
    
    // MARK: - Initialization
    
    init(modelName: String) {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to initialize CoreData \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentStoreContainer = container
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    func saveChanges() throws -> Bool {
        guard context.hasChanges else { return true }
        try context.save()
        return true
    }
    
    func createObject<T: NSManagedObject>(from entity: T.Type) throws -> T {
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: String(describing: entity),
            into: context
        ) as? T else {
            throw CoreDataServiceError.failCastToType(T.description())
        }
        return object
    }
    
    @discardableResult
    func deleteObject(_ object: NSManagedObject) throws -> Bool {
        context.delete(object)
        return try saveChanges()
    }
    
    func fetchObjects<T: NSManagedObject>(
        ofType entity: T.Type,
        sortBy sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        guard let request = entity.fetchRequest() as? NSFetchRequest<T> else { return [] }
        request.sortDescriptors = sortDescriptors
        return try context.fetch(request)
    }
}
