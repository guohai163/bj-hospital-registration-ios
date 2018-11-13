//
//  Track.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/12.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

// Query service creates Track objects
class Track {
    
    let name: String
    let artist: String
    let previewURL: URL
    let index: Int
    var downloaded = false
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
    
}
