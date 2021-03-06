//
//  CarousalCellView.swift
//  About Canada
//
//  Created by Krunal Purohit on 21/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- CarousalCell

class CarousalCell: ArticleCell {
    
    
    // MARK:- Internal: Inheritance ArticleCell
    
    override func setupCellView() {
        
        self.articleName.text = self.article.title
        self.articleName.font = Constants.carousalNameFont
        self.articleName.textColor = Constants.carousalNameColor
        self.articleName.textAlignment = .right
        
        self.articleImage.contentMode = .center
        
        self.descriptionText.text = self.article.description
        self.descriptionText.textColor = Constants.carousalDescriptionColor
        self.descriptionText.textAlignment = .center
        
        self.addSubview(self.articleName)
        self.addSubview(self.articleImage)
        self.addSubview(self.descriptionText)
        
        self.articleName.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 28, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: self.frame.width, heightConstant: 20)
        self.articleImage.anchor(self.articleName.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.articleImage.anchorCenterSuperview()
        self.descriptionText.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 16, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        // Try fetching Image if Article has URL
        if !self.article.imageURL.isEmpty {
            self.articleImage.loadImageUsingURLString(urlString: self.article.imageURL)
        }
    }
}
