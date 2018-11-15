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
    let id: Int
    let index: Int

    
    init(name: String, id: Int, index: Int) {
        self.name = name
        self.id = id

        self.index = index
    }
    
}
