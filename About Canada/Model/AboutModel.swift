//
//  AboutModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Foundation


// MARK:- About

// Making About Model Decodable so that JSON decoder can directly map service response accordingly.

struct About: Decodable {
    
    let title: String?
    let rows: [Article]?
}
