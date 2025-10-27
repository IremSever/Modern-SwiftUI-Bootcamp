//
//  APIExplorerUITests.swift
//  APIExplorerUITests
//
//  Created by İrem Sever on 26.10.2025.
//
import XCTest

final class APIExplorerUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // İstersen: app.launchArguments += ["-uiTests"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func testSearchAndOpenDetail() throws {
        let search = app.textFields["searchField"]
        XCTAssertTrue(search.waitForExistence(timeout: 10), "Search field not found")

        search.tap()
        search.typeText("rick")
        app.keyboards.buttons["search"].firstMatch.tapIfExists()
        app.keyboards.buttons["Return"].firstMatch.tapIfExists()

        let cell = app.staticTexts["Rick Sanchez"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 15)

        cell.firstMatch.tap()

        let title = app.staticTexts["detailTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 10), "Detail title not found")
    }
}

private extension XCUIElement {
    func tapIfExists() {
        if self.exists && self.isHittable { self.tap() }
    }
}
