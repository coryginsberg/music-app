//
//  SongDetails.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/27/23.
//

import Foundation
import SwiftUI

struct SongDetails: Identifiable {
  var id: String
  var color: Color
  var songTitle: String
  var artist: String
  var albumArt: Image
  var isExplicit: Bool
  var isDownloaded: Bool
}
