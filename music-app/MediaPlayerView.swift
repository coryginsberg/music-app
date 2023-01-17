//
//  MediaPlayerView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI

enum RepeatState {
  case noRepeat
  case repeatPlaylist
  case repeatSong
}

struct MediaPlayerView: View {
  public var color: Color
  
  @State private var isPlaying = false
  @State private var isPlayingIcon = "play.fill"
  @State private var repeatIcon = ("repeat", Color(.gray), RepeatState.noRepeat)
  @State private var isShuffle: Bool = false
  
  var body: some View {
    VStack {
      Image(systemName: "placeholdertext.fill")
        .scaleEffect(30.0)
        .frame(height: 500.0)
        .foregroundColor(color)
      HStack {
        MediaSecondaryButton(systemImage: "shuffle", color: isShuffle ? color : Color(.gray), action: self.shuffleSong)
        MediaPrimaryButton(systemImage: "backward.fill", color: color, action: self.prevSong)
        MediaPrimaryButton(systemImage: isPlayingIcon, color: color, action: self.togglePlay)
        MediaPrimaryButton(systemImage: "forward.fill", color: color, action: self.nextSong)
        MediaSecondaryButton(systemImage: repeatIcon.0, color: repeatIcon.1, action: self.loopSong)
      }
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
  
  func shuffleSong() -> Void {
    isShuffle.toggle()
    return
  }
  
  func loopSong() -> Void {
    switch repeatIcon.2 {
    case .noRepeat:
      self.repeatIcon = ("repeat", color, RepeatState.repeatPlaylist)
    case .repeatPlaylist:
      self.repeatIcon = ("repeat.1", color, RepeatState.repeatSong)
    case .repeatSong:
      self.repeatIcon = ("repeat", Color(.gray), RepeatState.noRepeat)
    }
    return
  }
}

struct MediaPrimaryButton: View {
  var systemImage = ""
  var color: Color
  var action: () -> Void
  
  var body: some View {
    Button(action: self.action) {
      Image(systemName: systemImage).font(.largeTitle)
    }
    .buttonStyle(.plain)
    .foregroundColor(color)
    .frame(maxWidth: 70.0, maxHeight: 40.0)
  }
}

struct MediaSecondaryButton: View {
  var systemImage = ""
  var color: Color
  var disabledColor: Color = Color(.gray)
  var action: () -> Void

  var body: some View {
    Button(action: self.action) {
      Image(systemName: systemImage).font(.title3)
    }
    .foregroundColor(color)
    .frame(maxWidth: 50.0)
  }
}

struct MediaPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPlayerView(color: .blue)
  }
}
