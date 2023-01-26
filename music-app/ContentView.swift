//
//  ContentView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import CoreData
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>

  var body: some View {
    TabView {
      SongsList()
        .tabItem {
          Label("Library", systemImage: "music.note.list")
        }
      Text("Browse")
        .tabItem {
          Label("Browse", systemImage: "square.grid.2x2.fill")
        }
      Text("Search")
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
