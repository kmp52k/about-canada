//
//  AboutError.swift
//  About Canada
//
//  Created by Krunal Purohit on 22/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Foundation


// MARK:- AboutError

enum AboutError: Error {
    
    case NoNetwork
    case InvalidJSON
    case ServerCallFailure
}
