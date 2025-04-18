//
//  PlayMusic.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 1/28/25.
//

import AVFoundation
import AVKit

class AudioPlayerViewModel: ObservableObject {
  var audioPlayer: AVAudioPlayer?

  @Published var isPlaying = false
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "tones", withExtension: ".m4a")
        else {return}
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch let error {
            print("Error playing sound.  \(error.localizedDescription)")
        }
    }
    
    func pauseSound() {
            audioPlayer?.pause()
    }
    
}
