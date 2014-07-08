//
//  APIController.swift
//  JamesQ
//
//  Created by Dean Chen on 6/25/14.
//  Copyright (c) 2014 Corklabs. All rights reserved.
//

import UIKit

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController {
    
    //include a delegate object, and to call this method when the connection finished loading some API data
    var delegate: APIControllerProtocol?
    
    init(delegate: APIControllerProtocol?) {
        self.delegate = delegate
    }
    
    func get(url: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true //turn on network activity indicator
        let manager = AFHTTPRequestOperationManager()
//        manager.requestSerializer.setValue(“608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: “X-Auth-Token”)
        manager.GET(
            url, //String format
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                NSLog("GET Success: " + responseObject.description)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false //turn off network activity indicator
                self.delegate?.didReceiveAPIResults(responseObject as NSDictionary)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                NSLog("GET Error: " + error.localizedDescription)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false //turn off network activity indicator
            })
    }
    
    func searchItunesFor(searchTerm: String) {
        // Now escape anything else that isn't URL-friendly
        let escapedSearchTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
        get(urlPath)
    }
    
    func lookupAlbum(collectionId: Int) {
        get("https://itunes.apple.com/lookup?id=\(collectionId)&entity=song")
    }
}
