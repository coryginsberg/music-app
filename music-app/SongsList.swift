//
//  SongsList.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/26/23.
//

import SwiftUI

// MARK: - SongsList

struct SongsList: View {
  @State var songDetails: SongItem?
  var body: some View {
    NavigationStack {
      List {
        Button("Mint") {
          songDetails = SongItem(
            id: "0",
            color: .mint)
        }
        Button("Pink") {
          songDetails = SongItem(
            id: "0",
            color: .pink)
        }
        Button("Teal") {
          songDetails = SongItem(
            id: "0",
            color: .teal)
        }
        Button("Indigo") {
          songDetails = SongItem(
            id: "0",
            color: .indigo)
        }
        Button("Yellow") {
          songDetails = SongItem(
            id: "0",
            color: .yellow)
        }
        Button("Green") {
          songDetails = SongItem(
            id: "0",
            color: .green)
        }
      }
      .sheet(item: $songDetails) { detail in
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

// MARK: - SongItem

struct SongItem: Identifiable {
  var id: String
  var color: Color
}

// MARK: - SongsList_Previews

struct SongsList_Previews: PreviewProvider {
  static var previews: some View {
    SongsList()
  }
}
