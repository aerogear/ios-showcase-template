//
//  RootRouter.swift
//  ios-showcase-template
//
//  Created by Wei Li on 08/11/2017.
//

import AGSAuth
import AGSPush
import Foundation
import UIKit

/*
 The router for the root view module. It is responsible to load child modules and attach them to the view.
 It should call the child module's corresponding builder class to build the child module, pass on the dependencies that are required.
 */
protocol RootRouter {
    var appComponents: AppComponents { get }
    var rootViewController: RootViewController { get }

    func launchFromWindow(window: UIWindow)
    func launchHomeView()
    func launchAuthenticationView()
    func launchStorageView()
    func launchDeviceTrustView()
    func launchPushView()
    func launchMetricsView()
    func launchURL(_ urlString: String)
    func openDocsPage(withLink docUrl: DocsURL, andTitle title: String)
    func launchUnderconstructionView(_ viewTitle: String)
    func launchLandingPageView(withTitle title: String, andContent content: ServiceDesciption)
}

class RootRouterImpl: RootRouter {
    let navViewController: UINavigationController
    let rootViewController: RootViewController
    let appComponents: AppComponents

    var homeRouter: HomeRouter?
    var authenticationRouter: AuthenticationRouter?
    var storageRouter: StorageRouter?
    var deviceTrustRouter: DeviceTrustRouter?
    var pushRouter: PushRouter?
    var metricsRouter: MetricsRouter?
    var webviewRouter: WebviewRouter?
    var underconstructionRouter: UnderconstructionRouter?
    var landingPageRouter: LandingPagesRouter?

    init(navViewController: UINavigationController, viewController: RootViewController, appComponents: AppComponents) {
        self.navViewController = navViewController
        self.rootViewController = viewController
        self.appComponents = appComponents
        
        NotificationCenter.default.addObserver(self, selector: #selector(showServiceConfigNotFoundDialog(notification:)), name: .serviceConfigMissing, object: nil)
    }
    
    @objc func showServiceConfigNotFoundDialog(notification: Notification) {
        var serviceName = ""
        var docsTitle: String?
        var docsUrl: DocsURL?
    
        if let serviceType = notification.object as? ServiceType {
            switch serviceType {
            case .auth:
                serviceName = "identity management"
                docsTitle = RootViewController.SUBMENU_ITEM_TITLE_IDM_SHOWCASE_DOCS
                docsUrl = DocsURL.idmClientAppDoc
            case .push:
                serviceName = "push"
                docsTitle = RootViewController.SUBMENU_ITEM_TITLE_PUSH_SHOWCASE_DOCS
                docsUrl = DocsURL.pushClientAppDoc
            }
        }
        
        // Construct the modal containing the error message and display it immediately.
        let alert = UIAlertController(title: "Feature Not Configured", message: "The service \(serviceName) does not have a configuration in mobile-services.json. Refer to the documentation for instructions on how to configure this service.", preferredStyle: .alert)
        if let documentationUrl = docsUrl, let documentationTitle = docsTitle {
            let docsAction = UIAlertAction(title: "Show Documentation", style: .default) { action in
                self.openDocsPage(withLink: documentationUrl, andTitle: documentationTitle)
            }
            alert.addAction(docsAction)
        }
        let exitAction = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(exitAction)
        self.rootViewController.present(alert, animated: true, completion: nil)
    }

    func launchFromWindow(window: UIWindow) {
        window.rootViewController = self.navViewController
        window.makeKeyAndVisible()
    }

    func launchHomeView() {
        if self.homeRouter == nil {
            self.homeRouter = HomeBuilder().build()
        }
        self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_HOME
        self.rootViewController.presentViewController(self.homeRouter!.viewController, true)
    }

    func launchAuthenticationView() {
        do {
            let authService = try self.appComponents.resolveAuthService()
            if self.authenticationRouter == nil {
                let authViewOptions = AuthenticationViewOptions(authLoginNavigationTitle: RootViewController.MENU_ITEM_TITLE_IDM_AUTH, authDetailsNavigationTitle: RootViewController.SUBMENU_ITEM_TITLE_IDM_AUTH_DETAILS, titleViewController: self.rootViewController)
                self.authenticationRouter = AuthenticationBuilder(authService: authService, authViewOptions).build()
            }
            self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_IDM_AUTH
            self.rootViewController.presentViewController(self.authenticationRouter!.initialViewController(user: try self.resolveCurrentUser()), true)
        } catch AgsAuth.Errors.noServiceConfigurationFound {
            NotificationCenter.default.post(name: .serviceConfigMissing, object: ServiceType.auth)
        } catch {
            print("Unexpected error")
        }
    }

    // Storage View
    func launchStorageView() {
        if self.storageRouter == nil {
            self.storageRouter = StorageBuilder(appComponents: self.appComponents).build()
        }
        self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_SEC_STORAGE
        self.rootViewController.presentViewController(self.storageRouter!.viewController, true)
    }

    // Device Trust View
    func launchDeviceTrustView() {
        if self.deviceTrustRouter == nil {
            self.deviceTrustRouter = DeviceTrustBuilder(appComponents: self.appComponents).build()
        }
        self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_SEC_TRUST
        self.rootViewController.presentViewController(self.deviceTrustRouter!.viewController, true)
    }

    func launchPushView() {
        if self.appComponents.isPushMissingConfig() {
            NotificationCenter.default.post(name: .serviceConfigMissing, object: ServiceType.push)
            return
        }
        if self.pushRouter == nil {
            self.pushRouter = PushBuilder().build()
        }
        self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_PUSH_MESSAGE
        self.rootViewController.presentViewController(self.pushRouter!.viewController, true)
    }
    
    func launchMetricsView() {
        if self.metricsRouter == nil {
            self.metricsRouter = MetricsBuilder().build()
        }
        self.rootViewController.title = RootViewController.MENU_ITEM_TITLE_METRICS
        self.rootViewController.presentViewController(self.metricsRouter!.viewController, true)
    }
    
    func launchURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    func resolveCurrentUser() throws -> User? {
        let authService = try self.appComponents.resolveAuthService()
        return try authService.currentUser()
    }
    
    func openDocsPage(withLink docUrl: DocsURL, andTitle title: String) {
        if self.webviewRouter == nil {
            self.webviewRouter = WebviewBuilder().build()
        }
        self.rootViewController.title = title
        self.rootViewController.presentViewController(self.webviewRouter!.viewController, true)
        self.webviewRouter?.viewController.loadUrl(docUrl.toURL())
    }
    
    func launchUnderconstructionView(_ viewTitle: String) {
        if self.underconstructionRouter == nil {
            self.underconstructionRouter = UnderconstructionBuilder().build()
        }
        self.rootViewController.title = viewTitle
        self.rootViewController.presentViewController(self.underconstructionRouter!.viewController, true)
    }
    
    func launchLandingPageView(withTitle title: String, andContent content: ServiceDesciption) {
        if self.landingPageRouter == nil {
            self.landingPageRouter = LandingPagesBuilder().build()
        }
        self.rootViewController.title = title
        self.rootViewController.presentViewController(self.landingPageRouter!.viewController, true)
        self.landingPageRouter?.viewController.loadText(header: content.header, contentList: content.contentList, footer: content.footer)
    }
}
