import Foundation
import UIKit

/*
 Builder class for the home module.
 This class should be used to build the home module, and the caller should be able to pass the required dependencies to it.
 */
class MetricsBuilder {
    func build() -> MetricsRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MetricsViewController") as! MetricsViewController
        
        let metricsRouter = MetricsRouterImpl(viewController: viewController)
        return metricsRouter
    }
}
