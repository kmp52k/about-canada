//
//  ArticleViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    let title: String
    let description: String
    let imageHref: String
    
    // Dependancy Injection (DI)
    init(article: Article) {
        self.title = article.title ?? ""
        self.description = article.title ?? ""
        self.imageHref = article.imageHref ?? ""
    }
}
