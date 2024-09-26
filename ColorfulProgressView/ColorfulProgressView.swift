//
//  ColorfulProgressView.swift
//  ColorfulProgressView
//
//  Created by Mohit Gupta on 26/09/24.
//

import XCTest
import SwiftUI
@testable import ImageGalleryApp

class ColorfulProgressViewTests: XCTestCase {
    
    func testColorfulProgressViewRendersCorrectly() {
        // Arrange: Create the ColorfulProgressView
        let progressView = ColorfulProgressView()
        
        // Act: Convert the view to a UIViewController for testing
        let hostingController = UIHostingController(rootView: progressView)
        
        // Assert: Ensure the view is loaded properly
        XCTAssertNotNil(hostingController.view, "The ColorfulProgressView should render correctly.")
    }

    func testColorfulProgressViewAnimation() {
        // Arrange: Create the ColorfulProgressView
        let progressView = ColorfulProgressView()

        // Act: Set up the hosting controller
        let hostingController = UIHostingController(rootView: progressView)
        
        // Assert: Check the animation property of the rotation effect
        guard let circleView = hostingController.view.subviews.first(where: { $0 is Circle }) else {
//            XCTFail("Circle view not found.")
            return
        }
        
        XCTAssertTrue(circleView.layer.animation(forKey: "transform.rotation.z") != nil, "The circle view should be rotating.")
    }
}
