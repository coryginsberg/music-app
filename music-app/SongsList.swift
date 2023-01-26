//
//  SongsList.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/26/23.
//

import SwiftUI

// MARK: - SongsList

struct SongsList: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Mint", value: Color.mint)
        NavigationLink("Pink", value: Color.pink)
        NavigationLink("Teal", value: Color.teal)
        NavigationLink("Indigo", value: Color.indigo)
        NavigationLink("Yellow", value: Color.yellow)
        NavigationLink("Green", value: Color.green)
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
    SongsList()
  }
}
