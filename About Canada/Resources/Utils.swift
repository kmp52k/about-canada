//
//  Utils.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import UIKit


// MARK:- Utils

class Utils {
    
    public static let shared = Utils()
    
    
    //MARK:- Private
    
    private var iPadDevice: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    private init() { }
    
    
    // MARK:- Public
    
    public func isNetworkAvailable() throws -> Bool {
        let reachability = NetworkReachabilityManager()
        if (reachability?.isReachable)! {
            return true
        } else {
            throw AboutError.noNetwork
        }
    }
    
    public func parseData(data: String) throws -> About {
        var dataString = data.replacingOccurrences(of: "\n", with: "")
        dataString = data.replacingOccurrences(of: "\t", with: "")
        let data = dataString.data(using: String.Encoding.utf8)
        do {
            let aboutData: About = try JSONDecoder().decode(About.self, from: data!)
            print("Title: \(String(describing: aboutData.title))")
            for article in aboutData.rows! {
                print(article.title ?? "")
                print(article.description ?? "")
                print(article.imageHref ?? "")
                print("------------------------------------------------------------------")
            }
            return aboutData
        } catch {
            print(error)
            throw AboutError.invalidJSON
        }
    }
    
    public func getColumnsForView() -> CGFloat {
        if !self.iPadDevice && UIDevice.current.orientation.isPortrait {
            return 1
        } else if self.iPadDevice && UIDevice.current.orientation.isLandscape {
            return 3
        } else {
            return 2
        }
    }
    
    public func getArticleCellSize() -> CGSize {
        
        let columns = self.getColumnsForView()
        var size = CGSize()
        size.width = (UIScreen.main.bounds.size.width - ((columns + 1) * Constants.articleInsets)) / columns
        size.height = Constants.articleHeight
        return size
    }
    
    public func getNavBarHidden() -> Bool {
        
        if self.iPadDevice { return false }
        else if UIDevice.current.orientation.isPortrait { return false }
        else { return true }
    }
}
