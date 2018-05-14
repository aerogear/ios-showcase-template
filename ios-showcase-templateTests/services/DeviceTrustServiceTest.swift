//
//  DeviceTrustServiceTest.swift
//  ios-showcase-templateTests
//
//  Created by Wei Li on 03/01/2018.
//

@testable import ios_showcase_template
import XCTest

class DeviceTrustServiceTest: XCTestCase {

    var trustServiceToTest: DeviceTrustService!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        trustServiceToTest = iosDeviceTrustService()
    }

    override func tearDown() {
        trustServiceToTest = nil
        super.tearDown()
    }

    func testPerformTrustChecks() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let detectors = trustServiceToTest.performTrustChecks()
        XCTAssertEqual(detectors.count, 5)
    }
}
