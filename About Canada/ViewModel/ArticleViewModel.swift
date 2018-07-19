//
//  ArticleViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import UIKit

struct ArticleViewModel {
    
    var title: String
    var imageURL: String
    var description: String
    var descriptionHeight: CGFloat = 0
    var size: CGSize
    
    // Dependancy Injection (DI)
    init(article: Article, size: CGSize) {
        self.title = article.title!
        self.size = size
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
        self.descriptionHeight = calculateDescriptionHeight()
    }
    
    func calculateDescriptionHeight() -> CGFloat {
        let approxwidth = self.size.width - 28 - 100 - 30
        let size = CGSize(width: approxwidth, height: 1000)
        let estimatedFrame = NSString(string: self.description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 14)], context: nil)
        if estimatedFrame.height < (118 - 48) {
            return 118
        }
        return estimatedFrame.height + 48
    }

}
