//
//  CardCellView.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit

class CardCell: ArticleCell {
    
    override func setupCellView() {
        
        self.backgroundColor = .black
        self.layer.cornerRadius = 5
        self.articleName.text = self.article.title
        self.articleName.textColor = Constants.carousalNameColor
        self.articleName.textAlignment = .center
        
        self.descriptionText.text = self.article.description
        self.descriptionText.textColor = Constants.carousalDescriptionColor
        self.descriptionText.textAlignment = .center
        self.descriptionText.numberOfLines = 0

        self.addSubview(self.articleName)
        self.addSubview(self.articleImage)
        self.addSubview(self.descriptionText)
        
        self.articleName.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.articleImage.topAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 20)
        self.articleImage.anchor(nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.descriptionText.anchor(self.articleImage.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
//        DispatchQueue.main.async {
//            if self.article.getDescriptionHeight(withWidth: self.frame.width - 18) > 20 {
//                print("c", self.article.getDescriptionHeight(withWidth: self.frame.width - 18))
//                self.descriptionText.anchor(self.articleImage.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: self.article.getDescriptionHeight(withWidth: self.frame.width - 18))
//            }
//        }
        
        if !self.article.imageURL.isEmpty {
            self.articleImage.loadImageUsingURLString(urlString: self.article.imageURL)
        }
        
    }
}
