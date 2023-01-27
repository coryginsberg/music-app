//
//  SongItem.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/27/23.
//

import SwiftUI

// MARK: - SongItem

struct SongItem: View {
  var songDetails: SongDetails
  @Binding var currentPlayingSongDetails: SongDetails?

  var body: some View {
    Button(songDetails.songTitle) {
      currentPlayingSongDetails = SongDetails(
        id: songDetails.id,
        color: songDetails.color,
        songTitle: songDetails.songTitle,
        artist: songDetails.artist,
        albumArt: songDetails.albumArt,
        isExplicit: songDetails.isExplicit,
        isDownloaded: songDetails.isDownloaded)
    }
  }
}
