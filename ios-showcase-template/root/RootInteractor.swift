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
    case deviceSecurityDoc = "https://docs.aerogear.org/aerogear/latest/security/index.html"
    case pushDoc = "https://docs.aerogear.org/aerogear/latest/push/index.html"
    case mericsDoc = "https://docs.aerogear.org/aerogear/latest/metrics/index.html"
    
    func toURL() -> URL {
        return URL(string: self.rawValue)!
    }
}

class RootInteractorImpl: RootInteractor {
    var router: RootRouter?


    func onMenuItemSelected(_ item: MenuItem) {
        switch item.type {
        case MenuItemType.home:
            router?.launchHomeView()
        case MenuItemType.identityManagement:
            print("Open IDM description page")
        case MenuItemType.identityManagementAuth:
            router?.launchAuthenticationView()
        case MenuItemType.identityManagementDocs:
            router?.openDocsPage(withLink: DocsURL.idmDoc, andTitle: RootViewController.MENU_ITEM_TITLE_IDM_DOCS)
        case MenuItemType.identityManagementSSO:
            router?.openDocsPage(withLink: DocsURL.idmSSODoc, andTitle: RootViewController.MENU_ITEM_TITLE_IDM_SSO)
        case MenuItemType.deviceSec:
            print("Open device security page")
        case MenuItemType.deviceSecDocs:
            router?.openDocsPage(withLink: DocsURL.deviceSecurityDoc, andTitle: RootViewController.MENU_ITEM_TITLE_SEC_DOCS)
        case MenuItemType.deviceSecTrust:
            router?.launchDeviceTrustView()
        case MenuItemType.deviceSecStorage:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_SEC_STORAGE)
        case MenuItemType.deviceSecPinning:
            router?.launchUnderconstructionView(RootViewController.MENU_ITEM_TITLE_SEC_PINNING)
        case MenuItemType.push:
            print("Open Push description page")
        case MenuItemType.pushDocs:
            router?.openDocsPage(withLink: DocsURL.pushDoc, andTitle: RootViewController.MENU_ITEM_TITLE_PUSH_DOCS)
        case MenuItemType.pushMessage:
            router?.launchPushView()
        case MenuItemType.metrics:
            router?.launchMetricsView()
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
