//
//  Track.swift
//  JamesQ
//
//  Created by Dean Chen on 6/27/14.
//  Copyright (c) 2014 Corklabs. All rights reserved.
//

import Foundation

class Track {
    
    var title: String?
    var price: String?
    var previewUrl: String?
    
    init(dict: NSDictionary!) {
        self.title = dict["trackName"] as? String
        self.price = dict["trackPrice"] as? String
        self.previewUrl = dict["previewUrl"] as? String
    }
}