//
//  MediaPlayerView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI

struct MediaPlayerView: View {
  public var color: Color
  
  @State private var isPlaying = false
  
  @State private var isPlayingIcon = "play.fill"
  
  var body: some View {
    VStack {
      Image(systemName: "placeholdertext.fill")
        .scaleEffect(30.0)
        .frame(height: 500.0)
        .foregroundColor(color)
      HStack {
        Button(action: prevSong) {
          Label("Previous", systemImage: "backward.fill")
            .labelStyle(.iconOnly)
            .accessibilityAddTraits([.isButton])
            .accessibilityLabel("Play")
        }
          .foregroundColor(color)
          .padding(.horizontal)
        Button(action: togglePlay) {
          Label("Play", systemImage: isPlayingIcon)
            .labelStyle(.iconOnly)
            .accessibilityAddTraits([.isButton, .startsMediaSession])
            .accessibilityLabel("Play")
        }
          .foregroundColor(color)
          .padding(.horizontal)
        Button(action: nextSong) {
          Label("", systemImage: "forward.fill")
            .labelStyle(.iconOnly)
            .accessibilityAddTraits([.isButton])
            .accessibilityLabel("Play")
        }
          .foregroundColor(color)
          .padding(.horizontal)
      }
        .scaledToFit()
        .scaleEffect(2.0)
        .frame(height: 100.0, alignment: .bottom)
    }
   
  }
  
  func prevSong() -> Void {
    return
  }
  
  func togglePlay() -> Void {
    isPlaying = !isPlaying
    if (isPlaying) {
      isPlayingIcon = "pause.fill"
    } else {
      isPlayingIcon = "play.fill"
    }
  }
  
  func nextSong() -> Void {
    return
  }
}

struct MediaPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPlayerView(color: .blue)
  }
}
