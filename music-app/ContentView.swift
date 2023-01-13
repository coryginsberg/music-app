//
//  ContentView.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
      animation: .default)
  private var items: FetchedResults<Item>

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
        MediaPlayerView(color: color)
      }
      .navigationTitle("Songs")
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
