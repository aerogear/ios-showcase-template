import Foundation
import UIKit

/* Manage the routing for the home view */
protocol MetricsRouter {
    var viewController: MetricsViewController { get }
}

class MetricsRouterImpl: MetricsRouter {
    let viewController: MetricsViewController
    
    init(viewController: MetricsViewController) {
        self.viewController = viewController
    }
}
