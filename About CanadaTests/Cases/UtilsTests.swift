//
//  UtilsTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 27/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class UtilsTests: XCTestCase {
    
    func testNetwork() {
        
        do {
            let result = try Utils.shared.isNetworkAvailable()
            XCTAssertEqual(result, true, "No Internet")
        } catch {
            XCTFail()
        }
    }
    
    func testInvalidJSONParsing() {
        
        do {
            _ = try Utils.shared.parseData(data: "{\"title\", \"About Canada\", \"rows\", []}")
            XCTFail()
        } catch {
            XCTAssertEqual(error as! AboutError, AboutError.InvalidJSON)
        }
    }
    
    func testParsingJSONString() {
        
        do {
            let result = try Utils.shared.parseData(data: "{\"title\": \"About Canada\", \"rows\": []}")
            XCTAssertEqual(result.title, "About Canada")
        } catch {
            XCTFail()
        }
    }
}
