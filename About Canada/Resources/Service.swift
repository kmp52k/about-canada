//
//  Service.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import Foundation

class Service {
    
    static let shared = Service()
    
    private init() { }
    
    func getAboutData() {
//        Alamofire.request(Constants.serviceURLString).responseData(completionHandler: { (response) in
////            let dataString = String(describing: response.data)
////            print(dataString)
//            guard let data = response.data else { return }
//            do {
//                let json = try JSONDecoder().decode(About.self, from: data)
//                print(json)
//            } catch {
//                print(error)
//            }
//        })
        
        Alamofire.request(Constants.serviceURLString).responseString { (response) in
            guard var dataString: String = response.value else { return }
            dataString = dataString.replacingOccurrences(of: "\n", with: "")
            dataString = dataString.replacingOccurrences(of: "\t", with: "")
            let data = dataString.data(using: String.Encoding.utf8)
            do {
                let json: About = try JSONDecoder().decode(About.self, from: data!)
                print("Title: \(String(describing: json.title))")
                for article in json.rows! {
                    print(article.title ?? "")
                    print(article.description ?? "")
                    print(article.imageHref ?? "")
                    print("------------------------------------------------------------------")
                }
            } catch {
                print(error)
            }
        }
    }
}
