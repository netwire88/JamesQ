//
//  DetailsViewController.swift
//  JamesQ
//
//  Created by Dean Chen on 6/26/14.
//  Copyright (c) 2014 Corklabs. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    
    @lazy var api: APIController = APIController(delegate: self)
    @IBOutlet var albumCover: UIImageView
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var tracksTableView: UITableView
    var album: Album?
    var tracks: Track[] = []
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: self.album?.largeImageURL))
        if self.album?.collectionId? {
            api.lookupAlbum(self.album!.collectionId!)
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
        
        var track = tracks[indexPath.row]
        cell.trackTitleLabel.text = track.title
        cell.playIcon.text = "▶️"
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        if let allResults = results["results"] as? NSDictionary[] {
            for trackInfo in allResults {  //each element is automatically a NSDictionary
                // Create the track
                if let kind = trackInfo["kind"] as? String {
                    if kind=="song" {
                        var track = Track(dict: trackInfo)  //uses init with Dictionary
                        tracks.append(track)
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tracksTableView.reloadData()
            })
    }
    
}
