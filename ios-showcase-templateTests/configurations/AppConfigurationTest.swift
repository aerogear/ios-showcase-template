//
//  AppConfigurationTest.swift
//  ios-showcase-templateTests
//
//  Created by Wei Li on 04/01/2018.
//

@testable import ios_showcase_template
import XCTest

class AppConfigurationTest: XCTestCase {

    var appConfigurationToTest: AppConfiguration!
    let configDict: NSDictionary = ["api-server": ["server-url": "http://server.example.com"]]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        appConfigurationToTest = AppConfiguration(configDict)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        appConfigurationToTest = nil
        super.tearDown()
    }

    func testApiServerConfig() {
        let apiServerConfig = appConfigurationToTest.apiServerConf
        XCTAssertNotNil(apiServerConfig)

        let apiServerDict = configDict.object(forKey: "api-server") as! NSDictionary

        let apiServerUrl = apiServerConfig.apiServerUrl
        XCTAssertEqual(apiServerUrl.absoluteString, apiServerDict.value(forKey: "server-url") as! String)
    }
}
