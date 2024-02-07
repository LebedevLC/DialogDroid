//
//  CoreDataChatMessage+CoreDataClass.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 07.02.2024.
//
//

import CoreData
import Foundation

@objc(CoreDataChatMessage)
public class CoreDataChatMessage: NSManagedObject {
    
    /// Заполнить свойства значениями из `MessageModel`
    func populate(from model: MessageModel) {
        identifier = model.identifier
        isFromUser = model.isFromUser
        timestamp = model.timestamp
        message = model.message
    }
}
