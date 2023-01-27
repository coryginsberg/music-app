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
  @State private var location: CGPoint = CGPoint(x: 50, y: 50)
  
  @GestureState private var fingerLocation: CGPoint? = nil
  @GestureState private var startLocation: CGPoint? = nil // 1

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
    ZStack(alignment: .bottom) {
      RoundedRectangle(cornerRadius: 48)
        .background(ignoresSafeAreaEdges: .bottom)
        .padding(.bottom, -35)
        .foregroundColor(.init(UIColor.systemGray3))
        
      VStack(alignment: .center) {
        Image(systemName: "placeholdertext.fill")
          .scaleEffect(30.0)
          .frame(height: 500.0)
          .foregroundColor(baseColor)
          .padding(.bottom, 100)
        HStack {
          MediaSecondaryButton(systemImage: "shuffle", color: isShuffle ? baseColor : Color(.gray), action: self.shuffleSong)
          MediaPrimaryButton(systemImage: "backward.fill", color: baseColor, action: self.prevSong)
          MediaPrimaryButton(systemImage: isPlayingIcon, color: baseColor, action: self.togglePlay)
          MediaPrimaryButton(systemImage: "forward.fill", color: baseColor, action: self.nextSong)
          MediaSecondaryButton(systemImage: repeatIcon.0, color: repeatIcon.1, action: self.loopSong)
        }
        .onAppear {
          UITabBar.appearance().barTintColor = UIColor(baseColor)
        }
        .padding(.bottom, 100)
      }    .gesture(simpleDrag.simultaneously(with: fingerDrag))

      
      if let fingerLocation = fingerLocation {
        Circle()
          .stroke(Color.green, lineWidth: 2)
          .frame(width: 60, height: 60)
          .position(fingerLocation)
      }
    }
    .toolbar(.hidden, for: .tabBar)
  }

  var simpleDrag: some Gesture {
      DragGesture()
          .onChanged { value in
              var newLocation = startLocation ?? location // 3
              newLocation.x += value.translation.width
              newLocation.y += value.translation.height
              self.location = newLocation
          }.updating($startLocation) { (value, startLocation, transaction) in
              startLocation = startLocation ?? location // 2
          }
  }
  
  var fingerDrag: some Gesture {
      DragGesture()
          .updating($fingerLocation) { (value, fingerLocation, transaction) in
              fingerLocation = value.location
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
