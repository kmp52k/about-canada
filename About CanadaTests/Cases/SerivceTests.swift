//
//  SerivceTests.swift
//  About CanadaTests
//
//  Created by Krunal Purohit on 27/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import XCTest

@testable import About_Canada

class SerivceTests: XCTestCase, AboutServiceDeligate {
    
    private var serviceDataExpectation: XCTestExpectation!
    private var response: About!
    
    func testServiceURL() {
        
        XCTAssertEqual(Constants.serviceURLString, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", "Invalid service URL.")
    }
    
    func testServiceData() {
        
        Service.shared.deligate = self
        self.serviceDataExpectation = expectation(description: "Response")
        
        Service.shared.getAboutData()
        
        wait(for: [self.serviceDataExpectation], timeout: 60)
        XCTAssertNotNil(response, "Invalid Service Response")
    }
    
    func handleAboutData(aboutResponse: About) {
        
        self.response = aboutResponse
        self.serviceDataExpectation.fulfill()
    }
    
    func handleAboutError(aboutError: AboutError) {
        
        self.serviceDataExpectation.fulfill()
    }
}
