//
//  ComeraTestUITests.swift
//  ComeraTestUITests
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import XCTest

final class ComeraTestUITests: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticlesList() throws {
        waitShortTime(2)
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["By Chelsia Rose Marcius, Robin Shulman Agüeros and Ana Ley"].tap()
        app.scrollViews.images.firstMatch.swipeDown()
        waitShortTime(1)
        app.scrollViews.images.firstMatch.swipeUp()
        app.navigationBars["Article"].buttons["Articles"].tap()
    }
    
    func testOpenArticleWebPage() throws {
        waitShortTime(2)
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["By Chelsia Rose Marcius, Robin Shulman Agüeros and Ana Ley"].tap()
        waitShortTime(1)
        app.scrollViews.images.firstMatch.swipeDown()
        elementsQuery.buttons["Full Article"].tap()
    }
    
    func testArticlesFilters() throws {
        waitShortTime(2)
                
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["By Chelsia Rose Marcius, Robin Shulman Agüeros and Ana Ley"].tap()
        app.navigationBars["Article"].buttons["Articles"].tap()
        
        let filterButton = app.navigationBars["Articles"].buttons["Filter"]
        filterButton.tap()
        
        waitShortTime(1)
        let elementsQuery2 = app.scrollViews.otherElements
        elementsQuery2.buttons["Yesterday"].tap()
        filterButton.tap()
        
        waitShortTime(1)
        elementsQuery2.buttons["30 Days"].tap()
        elementsQuery.staticTexts.firstMatch.swipeUp()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCTestCase {
    func waitShortTime(
        _ seconds: TimeInterval = 2,
        reason: String = "Wait short time"
    ) {
        let exp = expectation(description: reason)
        let _ = XCTWaiter.wait(for: [exp], timeout: seconds)
    }
}
