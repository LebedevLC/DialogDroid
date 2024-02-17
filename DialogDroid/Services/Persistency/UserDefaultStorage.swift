//
//  UserDefaultStorage.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 31.01.2024.
//

import Foundation

final class UserDefaultStorage {
    
    // MARK: - Public Properties
    
    static let shared = UserDefaultStorage()
    
    // MARK: - Private Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Initialization
    
    private init() {
        if !isLaunchedBefore {
            registeredDefaultSettings()
        }
    }
    
    // MARK: - Private Methods
    
    private func registeredDefaultSettings() {
        let values: [String: Any] = [
            ApplicationSettingsKeys.isMusicOn: true,
            ApplicationSettingsKeys.selectedMusicIndex: 3
        ]
        values.forEach({
            userDefaults.set($0.value, forKey: $0.key)
        })
    }
}

// MARK: - ApplicationStorage

extension UserDefaultStorage: ApplicationStorage {
    
    private enum ApplicationStorageKeys {
        static let isLaunchedBefore = Bundle.mainBundleIdentifier + ".isLaunchedBefore"
    }
    
    var isLaunchedBefore: Bool {
        get { userDefaults.bool(forKey: ApplicationStorageKeys.isLaunchedBefore) }
        set { userDefaults.set(newValue, forKey: ApplicationStorageKeys.isLaunchedBefore) }
    }
}

// MARK: - ApplicationSettings

extension UserDefaultStorage: ApplicationSettings {
    
    private enum ApplicationSettingsKeys {
        static let isMusicOn = Bundle.mainBundleIdentifier + ".isMusicOn"
        static let selectedMusicIndex = Bundle.mainBundleIdentifier + ".selectedMusicIndex"
        static let selectedRoleIndex = Bundle.mainBundleIdentifier + ".selectedRoleIndex"
    }
    
    var isMusicOn: Bool {
        get { userDefaults.bool(forKey: ApplicationSettingsKeys.isMusicOn) }
        set { userDefaults.set(newValue, forKey: ApplicationSettingsKeys.isMusicOn) }
    }
    
    var selectedMusicIndex: Int {
        get { userDefaults.integer(forKey: ApplicationSettingsKeys.selectedMusicIndex) }
        set { userDefaults.set(newValue, forKey: ApplicationSettingsKeys.selectedMusicIndex) }
    }
    
    var selectedRoleIndex: Int {
        get { userDefaults.integer(forKey: ApplicationSettingsKeys.selectedRoleIndex) }
        set { userDefaults.set(newValue, forKey: ApplicationSettingsKeys.selectedRoleIndex) }
    }
}
