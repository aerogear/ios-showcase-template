//
//  RootInteractor.swift
//  ios-showcase-template
//
//  Created by Wei Li on 08/11/2017.
//

import Foundation

protocol MenuListener {
    func onMenuItemSelected(_ item: MenuItem)
}

/*
 Specify the business logic of the app.
 It should handle the user's actions (received from the view controller), perform any required operations (business logic), and then use the router to navigate the views and pass data around if required.
 */
protocol RootInteractor: MenuListener {
    var router: RootRouter? { get set }
}

enum DocsURL: String {
    case idmDoc = "https://docs.aerogear.org/aerogear/latest/keycloak/index.html"
    case idmSSODoc = "https://docs.aerogear.org/aerogear/latest/keycloak/index.html?sso=1"
    case idmClientAppDoc = "https://docs.aerogear.org/aerogear/latest/showcase/idm.html"
    case deviceSecurityDoc = "https://docs.aerogear.org/aerogear/latest/security/index.html"
    case pushDoc = "https://docs.aerogear.org/aerogear/latest/push/index.html"
    case pushClientAppDoc = "https://docs.aerogear.org/aerogear/latest/showcase/push.html"
    case mericsDoc = "https://docs.aerogear.org/aerogear/latest/metrics/index.html"
    
    func toURL() -> URL {
        return URL(string: self.rawValue)!
    }
}

struct ServiceDesciption {
    let header: String
    let contentList: [String]
    var footer: String?
}

//enum ServiceIntroductions: ServiceDesciption {
//    case idmService = ServiceDesciption
//    """
//    <h1></h1>
//    <br />
//    <ul style="list-style-type: disc">
//    <li>
//    </ul>
//    """
//    case pushSerivce = """
//
//    * Code once and send push notifications to iOS and Android
//    * Push notifications to defined groups
//    * Push notifications to either iOS only or Android only
//    * Push notifications to different variants of a mobile app
//    * Push notifications from different back-end apps to the same mobile app
//    """
//    case metricsService = """
//
//
//    """
//    case deviceSecurityService = """
//    The security service allows you to easily configure and manage device security, and trust checks for your mobile app
//
//    """
//}

class RootInteractorImpl: RootInteractor {
    var router: RootRouter?

    let idmServiceDescription = ServiceDesciption(header: "The Identity Management service allows you to add authentication and authorization to your mobile app.", contentList: [
        "Secure your mobile app using the industry standard OpenID Connect protocol",
        "Add access control to your app based on user’s group membership",
        "Easily implement SSO, multi factor authentication and Social Login support",
        "Back end support for identity brokering and user federation"
        ], footer: nil)
    
    let deviceSecDescription = ServiceDesciption(header: "The Device Security service allows you to easily configure and manage device security, and trust checks for your mobile app", contentList: [
        "Perform a range of device trust checks on the mobile device, such as checking if the device is rooted, and allows you take proactive action based on the results",
        "Distribute SSL certificates with a mobile app to create a direct chain of trust (certificate pinning)"
    ], footer: nil)
    
    let pushServiceDescription = ServiceDesciption(header: "The Push Notification service allows you send native push notifications to different mobile operating systems.", contentList: [
        "Code once and send push notifications to iOS and Android",
        "Push notifications to defined groups",
        "Push notifications to either iOS only or Android only",
        "Push notifications to different variants of a mobile app",
        "Push notifications from different back-end apps to the same mobile app"
    ], footer: nil)
    
    let metricsServiceDescription = ServiceDesciption(header: "The Mobile Metrics service allows you gather metrics on mobile apps, device versions, device security checks and back-end mobile service usage.", contentList: [
      "Monitor usage by version of mobile app, platform and SDK",
      "Monitor interactions with the Identity Management service"
    ], footer: nil)

    func onMenuItemSelected(_ item: MenuItem) {
        switch item.type {
        case MenuItemType.home:
            router?.launchHomeView()
        case MenuItemType.identityManagement:
            router?.launchLandingPageView(withTitle: RootViewController.MENU_ITEM_TITLE_IDM, andContent: idmServiceDescription)
        case MenuItemType.identityManagementAuth:
            router?.launchAuthenticationView()
        case MenuItemType.identityManagementDocs:
            router?.openDocsPage(withLink: DocsURL.idmDoc, andTitle: RootViewController.MENU_ITEM_TITLE_IDM_DOCS)
        case MenuItemType.identityManagementSSO:
            router?.openDocsPage(withLink: DocsURL.idmSSODoc, andTitle: RootViewController.MENU_ITEM_TITLE_IDM_SSO)
        case MenuItemType.deviceSec:
            router?.launchLandingPageView(withTitle: RootViewController.MENU_ITEM_TITLE_SEC, andContent: deviceSecDescription)
        case MenuItemType.deviceSecDocs:
            router?.openDocsPage(withLink: DocsURL.deviceSecurityDoc, andTitle: RootViewController.MENU_ITEM_TITLE_SEC_DOCS)
        case MenuItemType.deviceSecTrust:
            router?.launchDeviceTrustView()
        case MenuItemType.deviceSecStorage:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_SEC_STORAGE)
        case MenuItemType.deviceSecPinning:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_SEC_PINNING)
        case MenuItemType.push:
            router?.launchLandingPageView(withTitle: RootViewController.MENU_ITEM_TITLE_PUSH, andContent: pushServiceDescription)
        case MenuItemType.pushDocs:
            router?.openDocsPage(withLink: DocsURL.pushDoc, andTitle: RootViewController.MENU_ITEM_TITLE_PUSH_DOCS)
        case MenuItemType.pushMessage:
            router?.launchPushView()
        case MenuItemType.metrics:
            router?.launchLandingPageView(withTitle: RootViewController.MENU_ITEM_TITLE_METRICS, andContent: metricsServiceDescription)
        case MenuItemType.metricsDocs:
            router?.openDocsPage(withLink: DocsURL.mericsDoc, andTitle: RootViewController.MENU_ITEM_TITLE_METRICS_DOCS)
        case MenuItemType.metricsProfile:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_METRICS_PROFILE)
        case MenuItemType.metricsTrust:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_METRICS_TRUST)
        default:
            print("no view to show")
        }
    }
}
