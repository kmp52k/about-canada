//
//  ArticleViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- ArticleViewModel

struct ArticleViewModel {
    
    
    // MARK:- Public
    
    var title: String
    var imageURL: String
    var description: String
    
    // Dependancy Injection (DI)
    init(article: Article) {
        
        self.title = article.title!
        if let dscr = article.description {
            self.description = dscr
        } else {
            self.description = ""
        }
        if let url = article.imageHref {
            self.imageURL = url
        } else {
            self.imageURL = "http://"
        }
    }
    
    func getDescriptionHeight(withWidth: CGFloat) -> CGFloat {
        
        let approxwidth = withWidth
        let size = CGSize(width: approxwidth, height: 1000)
        let estimatedFrame = NSString(string: self.description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: Constants.articleDescriptionFont], context: nil)
        return estimatedFrame.height
    }
}
