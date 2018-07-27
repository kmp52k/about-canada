//
//  CellsTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 27/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class CellsTests: XCTestCase {
    
    let article = Article(title: "Artile Title", description: "dexcription text", imageHref: "https://")
    
    func testArticleCellNotNil() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let articleCell = ArticleCell()
        articleCell.article = articalViewModel
        
        XCTAssertNotNil(articleCell.article)
        XCTAssertNotNil(articleCell.articleName)
        XCTAssertNotNil(articleCell.descriptionText)
        XCTAssertNotNil(articleCell.articleImage)
        XCTAssertNotNil(articleCell.descriptionText.text)
        XCTAssertNotNil(articleCell.articleImage.imageURLString)
    }
    
    func testArticleCell() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let articleCell = ArticleCell()
        articleCell.article = articalViewModel
        
        XCTAssertEqual(articleCell.articleName.text, self.article.title)
        XCTAssertEqual(articleCell.descriptionText.text, self.article.description)
        XCTAssertEqual(articleCell.articleImage.imageURLString, self.article.imageHref)
    }
    
    func testCardCellNotNil() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let cell = CardCell()
        cell.article = articalViewModel
        
        XCTAssertNotNil(cell.article)
        XCTAssertNotNil(cell.articleName)
        XCTAssertNotNil(cell.descriptionText)
        XCTAssertNotNil(cell.articleImage)
        XCTAssertNotNil(cell.descriptionText.text)
        XCTAssertNotNil(cell.articleImage.imageURLString)
    }
    
    func testCardCell() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let cell = CardCell()
        cell.article = articalViewModel
        
        XCTAssertEqual(cell.articleName.text, self.article.title)
        XCTAssertEqual(cell.descriptionText.text, self.article.description)
        XCTAssertEqual(cell.articleImage.imageURLString, self.article.imageHref)
    }
    
    func testCarousalCellNotNil() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let cell = CarousalCell()
        cell.article = articalViewModel
        
        XCTAssertNotNil(cell.article)
        XCTAssertNotNil(cell.articleName)
        XCTAssertNotNil(cell.descriptionText)
        XCTAssertNotNil(cell.articleImage)
        XCTAssertNotNil(cell.descriptionText.text)
        XCTAssertNotNil(cell.articleImage.imageURLString)
    }
    
    func testCarousalCell() {
        
        let articalViewModel = ArticleViewModel(article: self.article)
        let cell = CarousalCell()
        cell.article = articalViewModel
        
        XCTAssertEqual(cell.articleName.text, self.article.title)
        XCTAssertEqual(cell.descriptionText.text, self.article.description)
        XCTAssertEqual(cell.articleImage.imageURLString, self.article.imageHref)
    }
    
    func testErrorNotNilCell() {
        
        let errorViewModel = ErrorViewModel(error: AboutError.InvalidJSON)
        let cell = ErrorCell()
        cell.aboutError = errorViewModel
        
        XCTAssertNotNil(cell.aboutError)
    }
    
    func testErrorCell() {
        
        let errorViewModel = ErrorViewModel(error: AboutError.InvalidJSON)
        let cell = ErrorCell()
        cell.aboutError = errorViewModel
        
        XCTAssertEqual(cell.aboutError?.errorMessage.text, Constants.errorMessage)
        XCTAssertEqual(cell.aboutError?.errorImage.image, Constants.errorImage)
    }
}
