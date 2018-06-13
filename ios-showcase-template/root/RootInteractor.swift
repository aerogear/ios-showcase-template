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
            print("Open auth documentation using router?.launchURL(String)")
        case MenuItemType.identityManagementSSO:
            print("Open documentation page about using SSO in an iOS app")
        case MenuItemType.deviceSec:
            print("Open device security page")
        case MenuItemType.deviceSecDocs:
            print("Open device security documentation using router?.launchURL(String)")
        case MenuItemType.deviceSecStorage:
            router?.launchStorageView()
        case MenuItemType.deviceSecTrust:
            router?.launchDeviceTrustView()
        case MenuItemType.push:
            print("Open Push description page")
        case MenuItemType.pushDocs:
            print("Open push documentation using router?.launchURL(String)")
        case MenuItemType.pushMessage:
            router?.launchPushView()
        case MenuItemType.metrics:
            router?.launchMetricsView()
        case MenuItemType.metricsDocs:
            print("Open metrics documentation using router?.launchURL(String)")
        case MenuItemType.metricsTrust:
            print("Open metrics trust page")
        case MenuItemType.metricsProfile:
            print("Open metrics profile page")
        default:
            print("no view to show")
        }
    }
}
