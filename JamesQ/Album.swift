//
//  Album.swift
//  JamesQ
//
//  Created by Dean Chen on 6/26/14.
//  Copyright (c) 2014 Corklabs. All rights reserved.
//

import Foundation

class Album {
    var title: String?  //mark as optional
    var price: String?
    var thumbnailImageURL: NSURL?
    var largeImageURL: NSURL?
    var itemURL: NSURL?
    var artistURL: NSURL?
    var collectionId: Int?
    
    init(name: String!, price: String!, thumbnailImageURL: String!, largeImageURL: String!, itemURL: String!, artistURL: String!, collectionId: Int?) {
        self.title = name
        self.price = price
        self.thumbnailImageURL = NSURL(string: thumbnailImageURL)
        self.largeImageURL = NSURL(string: largeImageURL)
        self.itemURL = NSURL(string: itemURL)
        self.artistURL = NSURL(string: artistURL)
        self.collectionId = collectionId
    }
}