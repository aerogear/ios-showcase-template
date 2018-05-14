//
//  HomeRouter.swift
//  ios-showcase-template
//
//  Created by Wei Li on 08/11/2017.
//

import Foundation
import UIKit

/* Manage the routing for the home view */
protocol HomeRouter {
    var viewController: HomeViewController { get }
}

class HomeRouterImpl: HomeRouter {
    let viewController: HomeViewController

    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}
