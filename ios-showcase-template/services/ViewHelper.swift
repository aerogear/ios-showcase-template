//
//  ViewHelper.swift
//  ios-showcase-template
//
//  Created by Wei Li on 30/11/2017.
//

import Foundation
import NotificationBannerSwift

class ViewHelper {
    class func showChildViewController(parentViewController parent: UIViewController, childViewController child: UIViewController) {
        parent.addChildViewController(child)
        child.view.frame = parent.view.bounds
        parent.view.addSubview(child.view)
        child.didMove(toParentViewController: child)
    }
    
    class func removeViewController(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    class func showErrorBannerMessage(from: UIViewController, title: String, message: String) {
        let banner = NotificationBanner(title: title, subtitle: message, style: .danger)
        banner.show(bannerPosition: .bottom, on: from)
    }
    
    class func showSuccessBannerMessage(from: UIViewController, title: String, message: String) {
        let banner = NotificationBanner(title: title, subtitle: message, style: .success)
        banner.show(bannerPosition: .bottom, on: from)
    }
}


