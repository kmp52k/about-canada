//
//  Utils.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import Foundation

class Utils {
    
    public static let shared = Utils()
    
    private init() { }
    
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
}
