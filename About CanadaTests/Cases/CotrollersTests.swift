//
//  CotrollersTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 27/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class CotrollersTests: XCTestCase {
    
    let aboutLayout = AboutViewLayout()
    let pintrestLayout = PintrestLayout()
    let articles = [ArticleViewModel(article: Article(title: "Article1", description: "description", imageHref: "https://"))]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCollectionViewController() {
        
        let collectionViewController = CollectionViewController()
        XCTAssertNotNil(collectionViewController.layout)
        XCTAssertNotNil(collectionViewController.getRefreshControl())
        XCTAssertNotNil(collectionViewController.activityIndicatorView)
    }
    
    func testArticleViewController() {
        
        let collectionViewController = ArticleViewController()
        collectionViewController.articleViewModels = self.articles
        collectionViewController.viewDidLoad()
        
        XCTAssertEqual(collectionViewController.articleViewModels[0].title, self.articles[0].title)
        XCTAssertEqual(collectionViewController.articleViewModels[0].description, self.articles[0].description)
        XCTAssertEqual(collectionViewController.articleViewModels[0].imageURL, self.articles[0].imageURL)
    }
    
    func testPintrestViewController() {
        
        let collectionViewController = PintrestViewController(collectionViewLayout: pintrestLayout)
        collectionViewController.articleViewModels = self.articles
        collectionViewController.viewDidLoad()
        
        XCTAssertEqual(collectionViewController.articleViewModels[0].title, self.articles[0].title)
        XCTAssertEqual(collectionViewController.articleViewModels[0].description, self.articles[0].description)
        XCTAssertEqual(collectionViewController.articleViewModels[0].imageURL, self.articles[0].imageURL)
    }
}
