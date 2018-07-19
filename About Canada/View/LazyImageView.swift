//
//  LazyImageView.swift
//  About Canada
//
//  Created by Krunal Purohit on 19/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- LazyImageView

let imageCache = NSCache<AnyObject, AnyObject>()

class LazyImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingURLString(urlString: String) {
        self.imageURLString = urlString
        self.image = Constants.noImage
        let url = URL(string: urlString)!
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if response != nil {
                    let httpResponse = response as! HTTPURLResponse
                    if data != nil && httpResponse.statusCode == 200 {
                        let imageToCache = UIImage(data: data!)
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
