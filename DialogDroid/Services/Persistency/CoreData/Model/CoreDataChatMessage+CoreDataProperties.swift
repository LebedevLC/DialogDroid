//
//  CoreDataChatMessage+CoreDataProperties.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 07.02.2024.
//
//

import CoreData
import Foundation

extension CoreDataChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataChatMessage> {
        return NSFetchRequest<CoreDataChatMessage>(entityName: "CoreDataChatMessage")
    }
    
    /// Идентификатор сообщения
    @NSManaged public var identifier: UUID
    /// Флаг что сообщение от пользователя
    @NSManaged public var isFromUser: Bool
    /// Текст сообщения
    @NSManaged public var message: String
    /// Временная метка сохранения сообщения в БД
    @NSManaged public var timestamp: Date
}
