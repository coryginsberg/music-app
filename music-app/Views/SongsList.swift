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
      .sheet(item: $currentPlayingSongDetails,
             onDismiss: { currentPlayingSongDetails = nil },
             content: { detail in
               MediaPlayerView(baseColor: detail.color)
                 .presentationDragIndicator(.visible)
                 .presentationDetents([.large])
             })
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
    SongsList(allSongs: testSongs)
  }
}
