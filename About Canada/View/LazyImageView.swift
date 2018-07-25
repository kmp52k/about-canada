//
//  LazyImageView.swift
//  About Canada
//
//  Created by Krunal Purohit on 19/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit

// Image Cache to limit unnecessory Network calls
let imageCache = NSCache<AnyObject, AnyObject>()


// MARK:- LazyImageView

class LazyImageView: UIImageView {
    
    
    // MARK: Public
    
    var imageURLString: String?
    
    static func clearImageCache() {
        
        imageCache.removeAllObjects()
    }
    
    func loadImageUsingURLString(urlString: String) {
        
        self.imageURLString = urlString // Holding Image URL to make sure Image gets in Right Place during Async Calls
        self.image = Constants.noImage // Placeholder Image till Actual Image gets loaded Successfully
        let url = URL(string: urlString)!
        
        // Returning Imaage if available in Cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // Since Image is not Available in Cache, fetching it from URL
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if response != nil {
                    let httpResponse = response as! HTTPURLResponse
                    
                    // Checking for Success Response
                    if data != nil && httpResponse.statusCode == 200 {
                        let imageToCache = UIImage(data: data!)
                        
                        // Checking if current Image URL is same as Holding URL
                        if self.imageURLString == urlString && imageToCache != nil {
                            self.image = UIImage(data: data!)
                            imageCache.setObject(imageToCache as AnyObject, forKey: self.imageURLString as AnyObject)
                        }
                    }
                }
            }
        }).resume()
    }
}
