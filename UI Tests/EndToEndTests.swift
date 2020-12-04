//
//  EndToEndTests.swift
//  CovertgramUITests
//
//  Created by Eduardo Almeida on 15/11/2020.
//

import XCTest

class EndToEndTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchEnvironment = ["env": "mock"]
        
        setupSnapshot(app)
        
        app.launch()
    }
    
    func testWhileTakingSnapshots() {
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts["Tim Apple"], handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        app.buttons["wrench.and.screwdriver"].tap()
        
        //  XCTAssertTrue(app.staticTexts["tim_apple"].exists)
        //  XCTAssertTrue(app.staticTexts["manuela"].exists)
    }
}
