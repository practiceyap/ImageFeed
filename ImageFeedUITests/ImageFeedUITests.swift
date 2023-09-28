//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Muller Alexander on 27.09.2023.
//

import XCTest
@testable import ImageFeed

final class ImageFeedUITests: XCTestCase {

    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testAuth() throws {
        sleep(6)
        app.buttons["Authenticate"].tap()

        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 5))

        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))

        loginTextField.tap()
        loginTextField.typeText("mullerainvest@gmail.com")
        XCUIApplication().toolbars.buttons["Done"].tap()

        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))

        passwordTextField.tap()
        passwordTextField.typeText("Sashaicloud13")
        webView.tap()

        webView.buttons["Login"].tap()

        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)

        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }

    func testFeed() throws {
        sleep(6)
        let tablesQuery = app.tables

        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()

//        sleep(3)

        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)

        cellToLike.buttons["LikeButton"].tap()
        sleep(5)
        cellToLike.buttons["LikeButton"].tap()
        sleep(5)

        cellToLike.tap()

        sleep(2)

        let image = app.scrollViews.images.element(boundBy: 0)
        XCTAssertTrue(image.waitForExistence(timeout: 1))
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)

        let navBackButtonWhiteButton = app.buttons["backButton"]
        navBackButtonWhiteButton.tap()
    }

    func testProfile() throws {
        sleep(6)
            app.tabBars.buttons.element(boundBy: 1).tap()

            XCTAssertTrue(app.staticTexts["Alexander Muller"].exists)
            XCTAssertTrue(app.staticTexts["@imullera"].exists)

            app.buttons["logoutButton"].tap()
        sleep(1)
            app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
        sleep(1)
        XCTAssertTrue(app.buttons["Authenticate"].exists)
    }
}
