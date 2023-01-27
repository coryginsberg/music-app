//
//  SongsList.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/26/23.
//

import SwiftUI

// MARK: - SongsList

struct SongsList: View {
  var allSongs: [SongDetails]

  @State private var currentPlayingSongDetails: SongDetails?

  var body: some View {
    NavigationStack {
      List(allSongs) { song in
        SongItem(songDetails: song,
                 currentPlayingSongDetails: $currentPlayingSongDetails)
      }
      .sheet(item: $currentPlayingSongDetails) { detail in
        MediaPlayerView(baseColor: detail.color)
          .presentationDragIndicator(.visible)
          .presentationDetents([.large])
      }
      .navigationDestination(for: Color.self) { color in
        MediaPlayerView(baseColor: color)
      }
      .navigationTitle("Songs")
    }
  }
}

// MARK: - SongsList_Previews

struct SongsList_Previews: PreviewProvider {
  static var previews: some View {
    SongsList(allSongs: [SongDetails(id: "0",
                                     color: .mint,
                                     songTitle: "Love From The Other Side",
                                     artist: "Fall Out Boy",
                                     albumArt: .init(systemName: "play.square.fill"),
                                     isExplicit: false,
                                     isDownloaded: false),
                         SongDetails(id: "1",
                                     color: .yellow,
                                     songTitle: "Recession Proof",
                                     artist: "Nas",
                                     albumArt: .init(systemName: "play.square.fill"),
                                     isExplicit: true,
                                     isDownloaded: false)])
  }
}
