//
//  ModelTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 25/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class ModelTests: XCTestCase {
    
    let article = Article(title: "Artile Title", description: "dexcription text", imageHref: "https://")
    
    func testArticle() {
        
        XCTAssertEqual(article.title, "Artile Title", "title Proprty should not change post Initialization")
        XCTAssertEqual(article.description, "dexcription text", "description Proprty should not change post Initialization")
        XCTAssertEqual(article.imageHref, "https://", "imageHref Proprty should not change post Initialization")
    }
    
    func testAboutTitle() {
        
        let about = About(title: "About Canada", rows: [article])
        XCTAssertEqual(about.title, "About Canada", "title Proprty should not change post Initialization")
    }
    
    func testAboutRows() {
        
        let about = About(title: "About Canada", rows: [article])
        XCTAssertNotNil(about.rows, "rows Proprty should not change post Initialization")
    }
}
