//
//  AccessControlBuilder.swift
//  ios-showcase-template
//
//  Created by Wei Li on 14/12/2017.
//

import AGSAuth
import Foundation

class AccessControlBuilder {
    let appComponents: AppComponents

    init(appComponents: AppComponents) {
        self.appComponents = appComponents
    }

    func build() -> AccessControlRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AccessControlViewController") as! AccessControlViewController
        viewController.userIdentity = self.resolveCurrentUser()

        let accessControlRouter = AccessControlRouterImpl(viewController: viewController)
        return accessControlRouter
    }

    // tag::resolveCurrentUser[]
    func resolveCurrentUser() -> User? {
        do {
            let authService = try self.appComponents.resolveAuthService()
            return try! authService.currentUser()
        } catch {
            print("Unexpected error")
        }
        return nil
    } // This will all be removed before merging this.

    // end::resolveCurrentUser[]
}
