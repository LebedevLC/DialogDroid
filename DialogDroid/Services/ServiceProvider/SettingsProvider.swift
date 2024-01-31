//
//  SettingsProvider.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 31.01.2024.
//

import Foundation

protocol ServicesProvider {
    /// Хранилище параметров приложения
    var applicationStorage: ApplicationStorage { get }
    /// Хранилище настроек
    var settingsStorage: ApplicationSettings { get }
}

final class DefaultServicesProvider: ServicesProvider {
    
    // MARK: - Public Properties
    
    var applicationStorage: ApplicationStorage
    var settingsStorage: ApplicationSettings
    
    static let shared = DefaultServicesProvider()
    
    // MARK: - Private Properties
    
    private let userDefaultStorage = UserDefaultStorage.shared
    
    // MARK: - Initialization
    
    private init() {
        self.applicationStorage = userDefaultStorage
        self.settingsStorage = userDefaultStorage
    }
}
