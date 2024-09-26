//
//  ImageView.swift
//  ImageView
//
//  Created by Mohit Gupta on 26/09/24.
//

import XCTest
import SwiftUI
@testable import ImageGalleryApp

class ImageViewTests: XCTestCase {
    var viewModel: ImageGalleryViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ImageGalleryViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testImageViewDisplaysProgressViewInitially() {
        // Arrange: Create a mock photo and ImageView
        let photo = Photo(id: 1, title: "Sample Image", url: "https://via.placeholder.com/150", thumbnailUrl: "")
        let imageView = ImageView(photo: photo, viewModel: viewModel)
        
        // Act: Set up the hosting controller
        let hostingController = UIHostingController(rootView: imageView)

        // Assert: Initially, ProgressView should be shown since image hasn't loaded
//        XCTAssertTrue(hostingController.view.subviews.contains { $0 is UIActivityIndicatorView }, "ProgressView should be displayed while the image is loading.")
    }

    func testImageViewDisplaysImageAfterLoading() {
        // Arrange: Create a mock photo and ImageView
        let photo = Photo(id: 1, title: "Sample Image", url: "https://via.placeholder.com/150", thumbnailUrl: "")
        let imageView = ImageView(photo: photo, viewModel: viewModel)
        
        // Act: Load the image
        let hostingController = UIHostingController(rootView: imageView)
        
        // Simulate image loading
        viewModel.loadImage(for: photo) { loadedImage in
            // After image is loaded, the ImageView should update
            XCTAssertNotNil(loadedImage, "The image should be loaded.")
            XCTAssertFalse(hostingController.view.subviews.contains { $0 is UIActivityIndicatorView }, "ProgressView should disappear once the image is loaded.")
        }
    }
}
