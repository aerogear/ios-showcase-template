//
//  AuthenticationBuilder.swift
//  ios-showcase-template
//
//  Created by Wei Li on 08/11/2017.
//

import AGSAuth
import Foundation
import UIKit

struct AuthenticationViewOptions {
    var authLoginNavigationTitle: String
    var authDetailsNavigationTitle: String
    var titleViewController: BaseViewController
}

/*
 Builder class for the authentication module.
 This class should be used to build the authentication module, and the caller should be able to pass the required dependencies to it.
 */
class AuthenticationBuilder {
    let authService: AgsAuth
    let options: AuthenticationViewOptions

    init(authService: AgsAuth, _ options: AuthenticationViewOptions) {
        self.authService = authService
        self.options = options
    }

    func build() -> AuthenticationRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AuthenticationViewController") as! AuthenticationViewController
        let detailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "AuthenticationDetailsViewController") as! AuthenticationDetailsViewController

        let authenticationRouter = AuthenticationRouterImpl(viewController: viewController, detailsViewController: detailsViewController, options)
        let authenticationInteractor = AuthenticationInteractorImpl(authService: self.authService)
        authenticationInteractor.router = authenticationRouter

        viewController.authListener = authenticationInteractor
        detailsViewController.authListener = authenticationInteractor
        return authenticationRouter
    }
}
