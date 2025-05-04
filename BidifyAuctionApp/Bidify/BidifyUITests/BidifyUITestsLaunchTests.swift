//
//  BidifyUITestsLaunchTests.swift
//  BidEase
//
//  Created by user271456 on 5/3/25.
//


//
//  BidifyUITestsLaunchTests.swift
//  BidifyUITests
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import XCTest

final class BidifyUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
