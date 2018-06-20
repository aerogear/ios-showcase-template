//
//  WebviewBuilder.swift
//  ios-showcase-template

import Foundation
import UIKit

/*
 Builder class for the webview module.
 This class should be used to build the webview module, and the caller should be able to pass the required dependencies to it.
 */
class WebviewBuilder {
    func build() -> WebviewRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        
        let webviewRouter = WebviewRouterImpl(viewController: viewController)
        return webviewRouter
    }
}
