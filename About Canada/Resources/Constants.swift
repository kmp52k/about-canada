//
//  Constants.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- Constants

struct Constants {
    
    private init() {}
    
    static let navBarTitle = "About Canada"
    static let noConnectivityMessage = "No Internet. Check your data/wifi settings and try again."
    static let errorMessage = "Something went wrong. Try again later."
    static let invalidJSONError = "Invalid JSON Data."
    
    static let articleCellIdentifier = "articleCell"
    static let errorCellIdentifier = "errorCell"
    
    static let serviceURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let errorImage = UIImage(named: "error")
    static let noImage = UIImage(named: "no-image")
    static let errorImageHeight = CGFloat(120)
    static let errorMargin = CGFloat(20)
    static let articleHeight = CGFloat(200)
}


// MARK:- AboutError

enum AboutError: Error {
    
    case noNetwork
    case invalidJSON
    case serverCallFailure
}
