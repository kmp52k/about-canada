//
//  AboutViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 30/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Foundation


// MARK:- AboutViewModel

struct AboutViewModel {
    
    let title: String
    let rows: [ArticleViewModel]
    
    init(about: About) {
        
        var articles: [ArticleViewModel] = []
        
        if !(about.rows?.isEmpty)! {
            for article in (about.rows)! {
                guard let _ = article.title else { continue } // Ignoring articles without Title
                let articleViewModel = ArticleViewModel(article: article)
                articles.append(articleViewModel)
            }
        }
        
        self.title = about.title ?? ""
        self.rows = articles
    }
}
