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
    
    
    // MARK:- Public: Static
    
    static let navBarTitle = "About Canada"
    static let noConnectivityMessage = "No Internet. Check your data/wifi settings and try again."
    static let errorMessage = "Something went wrong. Try again later."
    static let invalidJSONError = "Invalid JSON Data."
    static let pagingText = "Article: "
    
    static let articleCellIdentifier = "articleCell"
    static let cardCellIdentifier = "cardCell"
    static let carousalCellIdentifier = "carousalCell"
    static let errorCellIdentifier = "errorCell"
    
    static let serviceURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let errorImage = UIImage(named: "error")
    static let noImage = UIImage(named: "no-image")
    static let cardsImage = UIImage(named: "cards")
    static let errorImageHeight = CGFloat(120)
    static let errorMargin = CGFloat(20)
    static let articleHeight = CGFloat(118)
    static let articleInsets = CGFloat(14)
    static let navigationTitleFontSize = CGFloat(20)
    static let navigationBarColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    static let statusBarColor = UIColor(red: 194/255, green: 31/255, blue: 31/255, alpha: 1)
    static let articleBackgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static let articleNameColor = UIColor(red: 152/255, green: 0, blue: 0, alpha: 1)
    static let articleNameFont = UIFont.boldSystemFont(ofSize: 18)
    static let articleNameLines = 0
    static let articleDescriptionColor = UIColor(red: 65/255, green: 65/255, blue: 64/255, alpha: 1)
    static let articleDescriptionFont = UIFont.italicSystemFont(ofSize: 14)
    static let articleDescriptionLines = 4
    static let articleImageSize = CGFloat(100)
    static let articleDeviderLine = UIColor(red: 152/255, green: 0, blue: 0, alpha: 1)
    static let carousalNameFont = UIFont.italicSystemFont(ofSize: 18)
    static let carousalNameColor = UIColor.white
    static let carousalDescriptionColor = UIColor.white
    static let carousalBackgroudColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    static let pagingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    static let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ◀︎ Back ", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    
    // MARK:- Private
    
    private init() {}
}
