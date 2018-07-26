//
//  ViewModelTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 26/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class ViewModelTests: XCTestCase {
    
    let article1 = Article(title: "Artile Title", description: "dexcription text", imageHref: "https://")
    let article2 = Article(title: "Artile Title", description: nil, imageHref: "https://")
    let article3 = Article(title: "Artile Title", description: "dexcription text", imageHref: nil)
    let article4 = Article(title: "Artile Title", description: "Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text. Test dexcription text.", imageHref: "https://")
    let errorViewModel1 = ErrorViewModel(error: AboutError.InvalidJSON)
    let errorViewModel2 = ErrorViewModel(error: AboutError.NoNetwork)
    let errorViewModel3 = ErrorViewModel(error: AboutError.ServerCallFailure)
    
    func testArticlModels() {
        
        let articalViewModel = ArticleViewModel(article: self.article1)
        
        XCTAssertEqual(articalViewModel.title, self.article1.title, "title Proprty should not change post Initialization")
        XCTAssertEqual(articalViewModel.description, self.article1.description, "description Proprty should not change post Initialization")
        XCTAssertEqual(articalViewModel.imageURL, self.article1.imageHref, "imageURL Proprty should not change post Initialization")
    }
    
    func testDescriptionNotNil() {
        
        let articalViewModel = ArticleViewModel(article: self.article2)
        
        XCTAssertNotNil(articalViewModel.description, "description property can not be nil, even if set nil should return empty string")
    }
    
    func testImageURLNotNil() {
        
        let articalViewModel = ArticleViewModel(article: self.article3)
        
        XCTAssertNotNil(articalViewModel.imageURL, "imageURL property can not be nil, even if set nil should not return empty string")
    }
    
    func testImageURLNotEmpty() {
        
        let articalViewModel = ArticleViewModel(article: self.article3)
        
        XCTAssertNotEqual(articalViewModel.imageURL, "", "imageURL property can not be empty/nil, even if set nil should not return empty string. Atleast it should be https://")
    }
    
    func testDescriptionTextHeightForWidth() {
        
        let articalViewModel = ArticleViewModel(article: self.article4)
        XCTAssertEqual(articalViewModel.getDescriptionHeight(withWidth: 100), 517.91796875, "\n For description text: \"\(String(describing: self.article4.description))\" \n with width: 100 \n calculated height with italic 14 size font should be \"517.91796875\"")
    }
    
    func testErrorLabelNotNil() {
        
        XCTAssertNotNil(self.errorViewModel1.errorMessage.text, "Error message text can not be nil")
        XCTAssertNotNil(self.errorViewModel2.errorMessage.text, "Error message text can not be nil")
        XCTAssertNotNil(self.errorViewModel3.errorMessage.text, "Error message text can not be nil")
    }
    
    func testErrorLabelText() {
        
        XCTAssertEqual(self.errorViewModel1.errorMessage.text, Constants.errorMessage, "Error message text should be \(Constants.errorMessage)")
        XCTAssertEqual(self.errorViewModel2.errorMessage.text, Constants.noConnectivityMessage, "Error message text should be \(Constants.noConnectivityMessage)")
        XCTAssertEqual(self.errorViewModel3.errorMessage.text, Constants.errorMessage, "Error message text should be \(Constants.errorMessage)")
    }
    
    func testErrorImageNotNil() {
        
        XCTAssertNotNil(self.errorViewModel1.errorImage.image, "Error image can not be nil")
        XCTAssertNotNil(self.errorViewModel2.errorImage.image, "Error image text can not be nil")
        XCTAssertNotNil(self.errorViewModel3.errorImage.image, "Error image text can not be nil")
    }
    
    func testErrorImage() {
        
        XCTAssertEqual(self.errorViewModel1.errorImage.image, Constants.errorImage, "Error image can not be changed")
        XCTAssertEqual(self.errorViewModel2.errorImage.image, Constants.errorImage, "Error image can not be changed")
        XCTAssertEqual(self.errorViewModel3.errorImage.image, Constants.errorImage, "Error image can not be changed")
    }
}
