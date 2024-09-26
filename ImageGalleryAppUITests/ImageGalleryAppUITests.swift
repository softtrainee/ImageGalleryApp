//
//  ImageGalleryAppUITests.swift
//  ImageGalleryAppUITests
//
//  Created by Mohit Gupta on 26/09/24.
//

import XCTest

class ImageGalleryUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testImageGridAndDetailNavigation() {
        // Wait for grid to load
        let collectionView = app.scrollViews.firstMatch
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5.0))
        
        // Tap on the first item in the grid
        let firstCell = collectionView.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        // Check if the detail view is displayed
        let detailView = app.scrollViews.firstMatch
        XCTAssertTrue(detailView.waitForExistence(timeout: 5.0))
        
        // Assert that the title label exists in the detail view
        let title = app.staticTexts.firstMatch
        XCTAssertTrue(title.exists)
    }
}
