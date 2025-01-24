//
//  SoundManager.swift
//  SweetLayers
//
//  Created by 1 on 18/01/25.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    var backgroundPlayer: AVAudioPlayer?
    var winPlayer: AVAudioPlayer?
    var losePlayer: AVAudioPlayer?
    var marketPlayer: AVAudioPlayer?
    var bonusPlayer: AVAudioPlayer?
    
    private init() {
        if let bgUrl = Bundle.main.url(forResource: "background", withExtension: "wav") {
            backgroundPlayer = try? AVAudioPlayer(contentsOf: bgUrl)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.prepareToPlay()
        }
        
        if let marketURL = Bundle.main.url(forResource: "market", withExtension: "wav") {
            marketPlayer = try? AVAudioPlayer(contentsOf: marketURL)
            marketPlayer?.numberOfLoops = -1
            marketPlayer?.prepareToPlay()
        }

        if let winUrl = Bundle.main.url(forResource: "won", withExtension: "mp3") {
            winPlayer = try? AVAudioPlayer(contentsOf: winUrl)
            winPlayer?.prepareToPlay()
        }

        if let loseUrl = Bundle.main.url(forResource: "lose", withExtension: "wav") {
            losePlayer = try? AVAudioPlayer(contentsOf: loseUrl)
            losePlayer?.prepareToPlay()
        }
        
        if let bonusURL = Bundle.main.url(forResource: "bonus", withExtension: "wav") {
            bonusPlayer = try? AVAudioPlayer(contentsOf: bonusURL)
            bonusPlayer?.prepareToPlay()
        }
    }
    
    func playBackgroundMusic() {
        backgroundPlayer?.play()
    }

    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
    }
    
    func playMarketMusic() {
        marketPlayer?.play()
    }

    func stopMarketMusic() {
        marketPlayer?.stop()
    }

    func playWinSound() {
        winPlayer?.play()
    }

    func playLoseSound() {
        losePlayer?.play()
    }
    
    func playBonusSound() {
        bonusPlayer?.play()
    }
    
    func setMusicVolume(_ volume: Float) {
        backgroundPlayer?.volume = volume
        marketPlayer?.volume = volume
    }
    
    func setSoundVolume(_ volume: Float) {
        winPlayer?.volume = volume
        losePlayer?.volume = volume
    }
}
