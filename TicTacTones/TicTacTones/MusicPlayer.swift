//
//  ContentView.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 1/27/25.
//

import SwiftUI


struct MusicPalyer: View {
  @StateObject var audioPlayerViewModel = AudioPlayerViewModel()

  var body: some View {
    VStack {
      Button(action: {
          if audioPlayerViewModel.isPlaying {
              audioPlayerViewModel.pauseSound()
              audioPlayerViewModel.isPlaying = false
          } else {
              audioPlayerViewModel.playSound()
              audioPlayerViewModel.isPlaying = true
          }
      }) {
        Image(systemName: audioPlayerViewModel.isPlaying ? "pause.circle" : "play.circle")
          .resizable()
          .frame(width: 64, height: 64)
      }
    }
  }
}
