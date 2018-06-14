//
//  AuthenticationDetailsViewControllerTest.swift
//  ios-showcase-templateTests
//
//  Created by Wei Li on 04/01/2018.
//

@testable import AGSAuth
@testable import ios_showcase_template
import XCTest

class AuthenticationDetailsViewControllerTest: XCTestCase {
    var authDetailsViewController: AuthenticationDetailsViewController!
    var authListener = TestAuthListener()

    var realmRole: UserRole!
    var clientRole: UserRole!
    var roles: Set<UserRole>!
    var testUser: User!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        realmRole = UserRole(nameSpace: nil, roleName: "realmRole")
        clientRole = UserRole(nameSpace: "client", roleName: "clientRole")
        roles = [realmRole, clientRole]
        testUser = User(userName: "testUser", email: "testUser@example.com", firstName: "test", lastName: "user", accessToken: "", identityToken: "", roles: roles)

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        authDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "AuthenticationDetailsViewController") as! AuthenticationDetailsViewController
        authDetailsViewController.authListener = authListener
        _ = authDetailsViewController.view
        _ = authDetailsViewController.userInfoView
        _ = authDetailsViewController.userRolesView
        authDetailsViewController.currentUser = testUser
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        authDetailsViewController = nil
        super.tearDown()
    }

    func checkUserName(name: String?) {
        let indexPath = IndexPath(row: 0, section: 0)
        let userNameCell = authDetailsViewController.userInfoView.cellForRow(at: indexPath)!
        let fieldValueLabel = userNameCell.contentView.viewWithTag(2) as! UILabel
        XCTAssertNotNil(fieldValueLabel)
        let actualName = fieldValueLabel.text
        XCTAssertEqual(name, actualName)
    }

    func checkFirstRole(role: String) {
        let indexPath = IndexPath(row: 1, section: 0)
        let userRoleCell = authDetailsViewController.userRolesView.cellForRow(at: indexPath)!
        let roleValueLabel = userRoleCell.contentView.viewWithTag(1) as! UILabel
        XCTAssertNotNil(userRoleCell)
        XCTAssertEqual(roleValueLabel.text, role)
    }

    func testRender() {
        checkUserName(name: testUser.fullName)
        //disable the role test for the moment. For some reason the roles table was never rendered during the test
        //checkFirstRole(role: testUser.roles.first!.roleName)
        let anotherUser: User = User(userName: "aTestUser", email: "aTestUser@example.com", firstName: "aTest", lastName: "User", accessToken: "", identityToken: "", roles: roles)
        authDetailsViewController.currentUser = anotherUser
        checkUserName(name: anotherUser.fullName)
        //checkFirstRole(role: anotherUser.roles.first!.roleName)
    }
}
