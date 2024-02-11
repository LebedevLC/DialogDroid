//
//  MusicPlayer.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 11.02.2024.
//

import AVFoundation

protocol MusicPlayer {
    func playAudio(fromURL url: URL)
    func stop()
}

final class DefaultMusicPlayer: MusicPlayer {
    
    // MARK: - Private Properties
    
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: - Public Methods
    
    func playAudio(fromURL url: URL) {
        do {
            audioPlayer?.stop()
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
