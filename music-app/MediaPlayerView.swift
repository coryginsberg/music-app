//
//  MediaPlayerView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI

enum RepeatState: String {
  case noRepeat = "noRepeat"
  case repeatPlaylist = "repeatPlaylist"
  case repeatSong = "repeatSong"
}

typealias RepeatTuple = (String, Color, RepeatState)

struct MediaPlayerView: View {
  
  public var baseColor: Color
  @State private var isPlaying = false
  @State private var isPlayingIcon = "play.fill"
  @State private var repeatIcon: RepeatTuple
  @State private var isShuffle: Bool
  
  private var savedValues = UserDefaults.standard
  
  init(baseColor: Color) {
    func setRepeatTuple(forState state: String) -> RepeatTuple {
      switch state {
      case RepeatState.noRepeat.rawValue:
        return ("repeat", Color(.gray), RepeatState.noRepeat)
      case RepeatState.repeatPlaylist.rawValue:
        return ("repeat", baseColor, RepeatState.repeatPlaylist)
      case RepeatState.repeatSong.rawValue:
        return ("repeat.1", baseColor, RepeatState.repeatSong)
      default:
        return ("repeat", Color(.gray), RepeatState.noRepeat)
      }
    }
    
    self.baseColor = baseColor
    self.repeatIcon = setRepeatTuple(forState: savedValues.string(forKey: "RepeatState") ?? RepeatState.noRepeat.rawValue)
    self.isShuffle = savedValues.bool(forKey: "ShuffleState")
  }
   
  var body: some View {
    VStack {
      Image(systemName: "placeholdertext.fill")
        .scaleEffect(30.0)
        .frame(height: 500.0)
        .foregroundColor(baseColor)
      HStack {
        MediaSecondaryButton(systemImage: "shuffle", color: isShuffle ? baseColor : Color(.gray), action: self.shuffleSong)
        MediaPrimaryButton(systemImage: "backward.fill", color: baseColor, action: self.prevSong)
        MediaPrimaryButton(systemImage: isPlayingIcon, color: baseColor, action: self.togglePlay)
        MediaPrimaryButton(systemImage: "forward.fill", color: baseColor, action: self.nextSong)
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
    savedValues.set(isShuffle, forKey: "ShuffleState")
    return
  }
  
  func loopSong() -> Void {
    var repeatTuple: (String, Color, RepeatState)
    switch repeatIcon.2 {
    case .noRepeat:
      repeatTuple = ("repeat", baseColor, RepeatState.repeatPlaylist)
    case .repeatPlaylist:
      repeatTuple = ("repeat.1", baseColor, RepeatState.repeatSong)
    case .repeatSong:
      repeatTuple = ("repeat", Color(.gray), RepeatState.noRepeat)
    }
    self.repeatIcon = repeatTuple
    savedValues.set(repeatTuple.2.rawValue, forKey: "RepeatState")
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
    MediaPlayerView(baseColor: .blue)
  }
}
