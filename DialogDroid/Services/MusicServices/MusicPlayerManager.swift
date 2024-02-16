//
//  MusicPlayerManager.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 11.02.2024.
//

import Foundation

protocol MusicPlayerManager {
    func changePlaying(isMusicOn: Bool)
    func changeMusic(to musicItem: MusicCollection)
}

final class DefaultMusicPlayerManager: MusicPlayerManager {
    
    // MARK: - Private Properties
    
    private let settingsStorage: ApplicationSettings
    private let musicPlayer: MusicPlayer
    
    // MARK: - Initialization
    
    init(settingsStorage: ApplicationSettings, musicPlayer: MusicPlayer) {
        self.settingsStorage = settingsStorage
        self.musicPlayer = musicPlayer
        configureMusic()
    }
    
    // MARK: - Public Methods
    
    func changePlaying(isMusicOn: Bool) {
        settingsStorage.isMusicOn = isMusicOn
        if isMusicOn {
            configureMusic()
        } else {
            musicPlayer.stop()
        }
    }
    
    func changeMusic(to musicItem: MusicCollection) {
        settingsStorage.selectedMusicIndex = musicItem.rawValue
        musicPlayer.stop()
        configureMusic()
    }
    
    // MARK: - Private Methods
    
    private func configureMusic() {
        guard settingsStorage.isMusicOn,
              let musicItem = MusicCollection(rawValue: settingsStorage.selectedMusicIndex),
              let url = musicItem.fileUrl
        else { return }
        musicPlayer.playAudio(fromURL: url)
    }
}
