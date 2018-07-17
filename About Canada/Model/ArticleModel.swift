//
//  ArticleModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Foundation


// MARK:- Article

struct Article: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
