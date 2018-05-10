//
//  StorageRouter.swift
//  ios-showcase-template
//
//  Created by Tom Jackman on 20/11/2017.
//

import Foundation

/* Manage the routing inside the storage view */
protocol StorageRouter {
    var viewController: StorageViewController {get}
}

/* Manage the routing inside the storage view */
class StorageRouterImpl: StorageRouter {
    let viewController: StorageViewController
    
    /**
     - Storage Router Initialisor
     
     - Parameter viewController: the storage view controller
     */
    init(viewController: StorageViewController) {
        self.viewController = viewController
    }
}
