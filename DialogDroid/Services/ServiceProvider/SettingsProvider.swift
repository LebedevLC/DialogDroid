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
    /// Менеджер работы с БД
    var coreDataManager: CoreDataManager { get }
    
    var musicPlayerManager: MusicPlayerManager { get }
    
    var aiManager: AIManager { get }
}

final class DefaultServicesProvider: ServicesProvider {
    
    // MARK: - Public Properties
    
    var applicationStorage: ApplicationStorage
    var settingsStorage: ApplicationSettings
    var coreDataManager: CoreDataManager
    var musicPlayerManager: MusicPlayerManager
    var aiManager: AIManager
    
    static let shared = DefaultServicesProvider()
    
    // MARK: - Private Properties
    
    private let userDefaultStorage = UserDefaultStorage.shared
    private let coreDataService: CoreDataService
    
    // MARK: - Initialization
    
    private init() {
        coreDataService = CoreDataService(modelName: "DataModel")
        coreDataManager = DefaultCoreDataManager(database: coreDataService)
        applicationStorage = userDefaultStorage
        settingsStorage = userDefaultStorage
        musicPlayerManager = DefaultMusicPlayerManager(
            settingsStorage: userDefaultStorage,
            musicPlayer: DefaultMusicPlayer()
        )
        aiManager = DefaultAIManager(client: DefaultAIClient(token: ApplicationConstants.key))
    }
}
