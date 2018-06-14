//
//  AuthenticationInteractor.swift
//  ios-showcase-template
//
//  Created by Wei Li on 08/11/2017.
//

import AGSAuth
import Foundation

/* Implement the business logic for the authentication view here. */
protocol AuthenticationInteractor: AuthListener {
    var authService: AgsAuth { get }
    var router: AuthenticationRouter? { get set }
}

class AuthenticationInteractorImpl: AuthenticationInteractor {
    let authService: AgsAuth
    var router: AuthenticationRouter?

    init(authService: AgsAuth) {
        self.authService = authService
    }

    // tag::login[]
    func startAuth(presentingViewController: UIViewController) {
        do {
            try self.authService.login(presentingViewController: presentingViewController, onCompleted: onLoginCompleted)
        } catch {
            fatalError("Unexpected error: \(error)")
        }
    }

    // end::login[]

    // tag::logout[]
    func logout() {
        do {
            try self.authService.logout(onCompleted: { error in
                self.router?.leaveUserDetailsView(withError: error)
            })
        } catch {
            fatalError("Unexpected error: \(error)")
        }
    }

    // end::logout[]

    func onLoginCompleted(user: User?, err: Error?) {
        self.router?.navigateToUserDetailsView(withIdentify: user, andError: err)
    }
}
