//
//  MediaPlayerView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI

// MARK: - RepeatState

enum RepeatState: String {
  case noRepeat
  case repeatPlaylist
  case repeatSong
}

typealias RepeatTuple = (String, Color, RepeatState)

// MARK: - MediaPlayerView

struct MediaPlayerView: View {
  public var baseColor: Color
  @State private var isPlaying = false
  @State private var isPlayingIcon = "play.fill"
  @State private var repeatIcon: RepeatTuple
  @State private var isShuffle: Bool
  @State private var isEditing = false

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
    self.repeatIcon = setRepeatTuple(forState: savedValues.string(forKey: "RepeatState")
      ?? RepeatState.noRepeat.rawValue)
    self.isShuffle = savedValues.bool(forKey: "ShuffleState")
  }

  var body: some View {
    VStack(alignment: .center) {
      Spacer(minLength: 50.0)
      Image(systemName: "placeholdertext.fill")
        .resizable()
        .frame(width: 250.0, height: 250.0)
        .foregroundColor(baseColor)
        .aspectRatio(contentMode: .fill)
        .padding(.vertical, 25.0)
        .padding(.horizontal)
      Spacer(minLength: 100.0)
      HStack(alignment: .center, content: {
        VStack(alignment: .leading, content: {
          Text("Hello World")
            .fontWeight(.semibold)
          Text("Hello World")
            .contextMenu(menuItems: {
              Button(
                action: {
                  print("Go to Album")
                },
                label: {
                  VStack {
                    Text("Go to Album")
                    Text("Hello World").foregroundColor(.secondary)
                  }
                  Image(systemName: "square.stack")
                })
              Button(
                action: {
                  print("Go to Artist")
                },
                label: {
                  VStack {
                    Text("Go to Artist")
                    Text("Hello World").foregroundColor(.secondary)
                  }
                  Image(systemName: "music.mic")
                })
            })
            .foregroundColor(.secondary)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        Button(action: {}, label: {
          Image(systemName: "ellipsis.circle.fill")
            .resizable()
            .frame(minWidth: 25, minHeight: 25)
            .aspectRatio(contentMode: .fill)
            .foregroundColor(baseColor)
        })
        .frame(maxWidth: 25, maxHeight: 25)
      })
      .frame(maxWidth: .infinity).padding(.horizontal)
      Slider(value: .constant(50.0),
             in: 0 ... 100,
             onEditingChanged: { editing in
               isEditing = editing
             })
             .padding(.horizontal, 25.0)
             .foregroundColor(baseColor)
             .progressViewStyle(.linear)
             .tint(baseColor)
      Spacer(minLength: 60)
      HStack {
        MediaSecondaryButton(systemImage: "shuffle",
                             color: isShuffle ? baseColor : Color(.gray),
                             action: self.shuffleSong)
        MediaPrimaryButton(systemImage: "backward.fill",
                           color: baseColor,
                           action: self.prevSong)
        MediaPrimaryButton(systemImage: isPlayingIcon,
                           color: baseColor,
                           action: self.togglePlay)
        MediaPrimaryButton(systemImage: "forward.fill",
                           color: baseColor,
                           action: self.nextSong)
        MediaSecondaryButton(systemImage: repeatIcon.0,
                             color: repeatIcon.1,
                             action: self.loopSong)
      }
      .onAppear {
        UITabBar.appearance().barTintColor = UIColor(baseColor)
      }
      .padding(.bottom, 60.0)
      Slider(value: .constant(50.0),
             in: 0 ... 100,
             label: {
               Label(title: {}, icon: {})
             },
             minimumValueLabel: {
               Label("", systemImage: "speaker.fill")
             },
             maximumValueLabel: {
               Label("", systemImage: "speaker.wave.3.fill")
             },
             onEditingChanged: { editing in
               isEditing = editing
             })
             .padding(.horizontal, 25.0)
             .foregroundColor(baseColor)
             .tint(baseColor)
      Spacer(minLength: 60.0)
    }
  }

  func prevSong() {}

  func togglePlay() {
    isPlaying = !isPlaying
    if isPlaying {
      isPlayingIcon = "pause.fill"
    } else {
      isPlayingIcon = "play.fill"
    }
  }

  func nextSong() {}

  func shuffleSong() {
    isShuffle.toggle()
    savedValues.set(isShuffle, forKey: "ShuffleState")
  }

  func loopSong() {
    var repeatTuple: (String, Color, RepeatState)
    switch repeatIcon.2 {
    case .noRepeat:
      repeatTuple = ("repeat", baseColor, RepeatState.repeatPlaylist)
    case .repeatPlaylist:
      repeatTuple = ("repeat.1", baseColor, RepeatState.repeatSong)
    case .repeatSong:
      repeatTuple = ("repeat", Color(.gray), RepeatState.noRepeat)
    }
    repeatIcon = repeatTuple
    savedValues.set(repeatTuple.2.rawValue, forKey: "RepeatState")
  }
}

// MARK: - MediaPrimaryButton

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

// MARK: - MediaSecondaryButton

struct MediaSecondaryButton: View {
  var systemImage = ""
  var color: Color
  var disabledColor: Color = .init(.gray)
  var action: () -> Void

  var body: some View {
    Button(action: self.action) {
      Image(systemName: systemImage).font(.title3)
    }
    .foregroundColor(color)
    .frame(maxWidth: 50.0)
  }
}

// MARK: - MediaPlayerView_Previews

struct MediaPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPlayerView(baseColor: .blue)
  }
}
