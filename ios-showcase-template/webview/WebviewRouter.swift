//
//  WebviewRouter.swift
//  ios-showcase-template

import Foundation
import UIKit

protocol WebviewRouter {
    var viewController: WebviewViewController { get }
}

class WebviewRouterImpl: WebviewRouter {
    let viewController: WebviewViewController
    
    init(viewController: WebviewViewController) {
        self.viewController = viewController
    }
}
