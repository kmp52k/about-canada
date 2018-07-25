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
            throw AboutError.NoNetwork
        }
    }
    
    public func parseData(data: String) throws -> About {
        
        // Since incoming data is not proper JSON need to remove \n & \t from the response
        var dataString = data.replacingOccurrences(of: "\n", with: "")
        dataString = data.replacingOccurrences(of: "\t", with: "")
        let data = dataString.data(using: String.Encoding.utf8)
        do {
            let aboutData: About = try JSONDecoder().decode(About.self, from: data!)
            return aboutData
        } catch {
            print(error)
            throw AboutError.InvalidJSON
        }
    }
    
    public func isPortrait() -> Bool { // Checking manually since UIDevice.current.orientation.isPortrait don't work properly on device launch
        
        if UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            return true
        }
        return false
    }
    
    public func getColumnsForView() -> CGFloat {
        
        if !self.iPadDevice && self.isPortrait() {
            return 1
        } else if self.iPadDevice && !self.isPortrait() {
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
        else if self.isPortrait() { return false }
        else { return true }
    }
}
