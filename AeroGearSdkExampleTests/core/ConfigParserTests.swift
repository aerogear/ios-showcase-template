
@testable import AGSCore
import Foundation
import XCTest

class ConfigParserTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigParsingValidFile() {
        let jsonData = ConfigParser.readLocalJsonData("mobile-services")
        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(MobileConfig.self, from: jsonData!)
            XCTAssertNotNil(config)
        } catch {
            XCTFail("Error when decoding file")
        }
    }

    func testConfigParsingInValidFile() {
        let jsonData = ConfigParser.readLocalJsonData("invalid")
        XCTAssertNil(jsonData)
    }
}
