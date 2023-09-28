//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Muller Alexander on 27.09.2023.
//

@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    func testImagesListViewControllerCallsViewDidLoad() {
        let imagesListViewController = ImagesListViewController()
        let imagesListViewPresenter = ImagesListViewPresenterSpy()
        imagesListViewController.configure(imagesListViewPresenter)
        imagesListViewController.updateImagesListDetails()
        
        XCTAssertTrue(imagesListViewPresenter.updateIsCalled)
    }
}

