//
//  SongDetails.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/27/23.
//

import Foundation
import SwiftUI

// MARK: - SongDetails

public struct SongDetails: Identifiable {
  public var id: String
  var color: Color
  var songTitle: String
  var artist: String
  var albumArt: Image
  var isExplicit: Bool
  var isDownloaded: Bool
}

let testSongs: [SongDetails] = [
  SongDetails(id: "\(Int.random(in: 0..<100))",
              color: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
              songTitle: "Love From The Other Side",
              artist: "Fall Out Boy",
              albumArt: .init(systemName: "play.square.fill"),
              isExplicit: .random(),
              isDownloaded: .random()),
  SongDetails(id: "\(Int.random(in: 0..<100))",
              color: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
              songTitle: "Love From The Other Side",
              artist: "Fall Out Boy",
              albumArt: .init(systemName: "play.square.fill"),
              isExplicit: .random(),
              isDownloaded: .random()),
  SongDetails(id: "\(Int.random(in: 0..<100))",
              color: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
              songTitle: "Love From The Other Side",
              artist: "Fall Out Boy",
              albumArt: .init(systemName: "play.square.fill"),
              isExplicit: .random(),
              isDownloaded: .random()),
  SongDetails(id: "\(Int.random(in: 0..<100))",
              color: Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
              songTitle: "Love From The Other Side",
              artist: "Fall Out Boy",
              albumArt: .init(systemName: "play.square.fill"),
              isExplicit: .random(),
              isDownloaded: .random())
]
