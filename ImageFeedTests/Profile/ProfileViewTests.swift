//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Muller Alexander on 27.09.2023.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfilePresenterSpy()
        profileViewController.configure(profileViewPresenter)
        
        _ = profileViewController.view
        
        XCTAssertTrue(profileViewPresenter.viewDidLoadCalled)
    }
}
