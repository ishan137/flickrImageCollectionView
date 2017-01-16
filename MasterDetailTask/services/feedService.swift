//
//  feedService.swift
//  MasterDetailTask
//
//  Created by Ishan Baboota on 15/01/17.
//  Copyright © 2017 Ishan Baboota. All rights reserved.
//

import Foundation
import UIKit

//Function to retrieve data from API and parse the json
func feedService(completion: @escaping () -> ()) {

let url = NSURL(string: URL_String)

let urlRequest = NSURLRequest(url: url! as URL)

let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {
    (data, response, error) in
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
            else {
                print("error unwrapping nil")
                return
            }
        
        if let teams = json["items"] as? [[String:Any]] {
            for team in teams {
                let feeds = FlickrData()
                if let name = team["title"] as? String {
                    feeds.title = team["title"] as! String
                }
                
                if let picture = team["media"] as? [String:Any] {
                    if let pictureLink = picture["m"] as? String {
                        feeds.imageURL = pictureLink
                        if let imageData = getPhotoDataWithURL(url: pictureLink) {
                        feeds.flickrImage = UIImage(data: imageData as Data)
                        }

                    }
                }
                
                if let description = team["description"] as? String {
                    feeds.description = team["description"] as! String
                }
                feedData.append(feeds)
            }

            completion()
            
        }
    } catch {
        print("error serializing JSON: \(error)")
        
        completion()
    }
    
}).resume()

}

// To retrieve image from the media link
func getPhotoDataWithURL(url: String) -> NSData? {
        
        if let photoURL = NSURL(string: url) {
            do {
                let imageData = try NSData(contentsOf: photoURL as URL, options: NSData.ReadingOptions.mappedIfSafe)
                return imageData
            } catch {
                return nil
            }
        }
        return nil
}
