//
//  AppConfiguration.swift
//  ios-showcase-template
//
//  Created by Wei Li on 07/11/2017.
//

import Foundation

struct ApiServerConfiguration {
    let apiServerUrl: URL
}

class AppConfiguration {
    static let API_SERVER_KEY = "api-server"
    static let API_SERVER_URL_KEY = "server-url"
    let apiServerConf: ApiServerConfiguration
    
    init(_ configuration: NSDictionary) {
        apiServerConf = AppConfiguration.initApiServerConfig(configuration.object(forKey: AppConfiguration.API_SERVER_KEY) as! NSDictionary)
    }
    
   class func initApiServerConfig(_ apiServerConfig: NSDictionary) -> ApiServerConfiguration {
        let apiServerUrl = URL(string: apiServerConfig.value(forKey: AppConfiguration.API_SERVER_URL_KEY) as! String)
        return ApiServerConfiguration(apiServerUrl: apiServerUrl!)
    }
}
