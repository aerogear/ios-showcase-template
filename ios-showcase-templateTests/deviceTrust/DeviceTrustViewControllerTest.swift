//
//  DeviceTrustViewControllerTest.swift
//  ios-showcase-templateTests
//
//  Created by Wei Li on 04/01/2018.
//

@testable import ios_showcase_template
import XCTest
import AGSSecurity

class FakeDeviceTrustListener: DeviceTrustListener {
    func performTrustChecks() -> [DeviceCheckResult] {
        let result = DeviceCheckResult("test", false)
        return [result]
    }
}

class DeviceTrustViewControllerTest: XCTestCase {
    var deviceTrustVCToTest: DeviceTrustViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        deviceTrustVCToTest = mainStoryboard.instantiateViewController(withIdentifier: "DeviceTrustViewController") as! DeviceTrustViewController
        deviceTrustVCToTest.deviceTrustListener = FakeDeviceTrustListener()
        deviceTrustVCToTest.CHECKS_RESULT = ["test": [true: "test", false: "test", DeviceTrustViewController.SECURE_WHEN_FALSE: false]];
        UIApplication.shared.keyWindow!.rootViewController = deviceTrustVCToTest
        _ = deviceTrustVCToTest.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deviceTrustVCToTest = nil
        super.tearDown()
    }

    func testRender() {
        XCTAssertEqual(deviceTrustVCToTest.deviceTrustScoreLabel.text, "0%")
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = deviceTrustVCToTest.deviceTrustTableView.cellForRow(at: indexPath)
        XCTAssertNotNil(cell)
    }
}
