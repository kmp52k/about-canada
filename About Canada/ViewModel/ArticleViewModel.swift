//
//  ArticleViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

struct ArticleViewModel {
    
    var title: String
    var imageURL: String
    var description: String

    let articleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let articleImage: UIImageView = {
        let view = UIImageView(image: Constants.noImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    // Dependancy Injection (DI)
    init(article: Article) {
        self.articleName.text = article.title
        self.title = article.title!
        self.description = String(describing: article.description)
        if let url = article.imageHref {
            self.imageURL = url
        } else {
            self.imageURL = "http://"
        }
    }

}
