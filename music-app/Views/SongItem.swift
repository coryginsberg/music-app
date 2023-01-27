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
    Button(action: {
      currentPlayingSongDetails = SongDetails(
        id: songDetails.id,
        color: songDetails.color,
        songTitle: songDetails.songTitle,
        artist: songDetails.artist,
        albumArt: songDetails.albumArt,
        isExplicit: songDetails.isExplicit,
        isDownloaded: songDetails.isDownloaded)
    }) {
      HStack {
        songDetails.albumArt
        VStack(alignment: .leading) {
          HStack {
            Text(songDetails.songTitle)
              .dynamicTypeSize(...DynamicTypeSize.medium)
            if songDetails.isExplicit {
              Image(systemName: "e.square.fill")
            }
          }

          Text(songDetails.artist)
            .dynamicTypeSize(...DynamicTypeSize.xSmall)
            .foregroundColor(.secondary)
        }
        .padding(.leading)
        if songDetails.isDownloaded {
          Spacer()
          DownloadedImage()
        }
      }.frame(maxWidth: .infinity, alignment: .leading)
    }
    .foregroundColor(.primary)
  }
}

// MARK: - DownloadedImage

struct DownloadedImage: View {
  var body: some View {
    Image(systemName: "arrow.down.circle.fill")
      .foregroundColor(.secondary)
      .frame(width: .infinity, alignment: .trailing)
  }
}

// MARK: - SongItem_Previews

struct SongItem_Previews: PreviewProvider {
  static var previews: some View {
    SongItem(songDetails: SongDetails(id: "0",
                                      color: .mint,
                                      songTitle: "Love From The Other Side",
                                      artist: "Fall Out Boy",
                                      albumArt: .init(systemName: "play.square.fill"),
                                      isExplicit: false,
                                      isDownloaded: true),
             currentPlayingSongDetails: .constant(SongDetails(id: "0",
                                                              color: .mint,
                                                              songTitle: "Love From The Other Side",
                                                              artist: "Fall Out Boy",
                                                              albumArt: .init(systemName: "play.square.fill"),
                                                              isExplicit: false,
                                                              isDownloaded: true)))
  }
}
