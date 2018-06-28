//
//  AppComponents.swift
//  ios-showcase-template
//
//  Created by Wei Li on 09/11/2017.
//

import AGSAuth
import AGSCore
import AGSPush
import Foundation
import SwiftKeychainWrapper

extension Notification.Name {
    static let serviceConfigMissing = Notification.Name("serviceConfigMissing")
    static let pushServiceRegistrationFailure = Notification.Name("pushServiceRegistrationFailure")
}

enum ServiceType {
    case auth
    case push
}

class AppComponents {
    let appConfiguration: AppConfiguration
    let kcWrapper: KeychainWrapper

    var authService: AgsAuth?
    var pushService: AgsPush?
    
    var storageService: StorageService?
    let REALM_STORAGE_KEYCHAIN_ALIAS = "realm-db-keychain"
    var deviceTrustService: DeviceTrustService?
    var missingPushConfig = false
    var failedPushRegistrationError: Error?
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        self.kcWrapper = KeychainWrapper.standard
    }

    // tag::initAuthService[]
    func resolveAuthService() throws -> AgsAuth {
        if self.authService == nil {
            let authConfig = AuthenticationConfig(redirectURL: "org.aerogear.ios-showcase-template:/callback")
            try AgsAuth.instance.configure(authConfig: authConfig)
            self.authService = AgsAuth.instance
        }
        return self.authService!
    }
    // end::initAuthService[]

    func resolvePushService() -> AgsPush {
        if self.pushService == nil {
            self.pushService = AgsPush.instance
        }
        return self.pushService!
    }
    
    func isPushMissingConfig() -> Bool {
        return missingPushConfig;
    }
    
    func registerPushService(_ deviceToken: Data) {
        var config = UnifiedPushConfig()
        config.alias = "Example App"
        config.categories = ["iOS", "Example"]
        do {
            try self.resolvePushService().register(deviceToken, config,
              success: {
                AgsCore.logger.info("Successfully registered to Unified Push Server")
            },
                failure: { (error: Error!) in
                AgsCore.logger.error("Failure to register for on Unified Push Server: \(error)")
            })
        } catch {
            self.missingPushConfig = true
        }
    }
    
    func failPushServiceRegistration(_ error: Error) {
        self.failedPushRegistrationError = error
    }
    
    // Setup the Storage Service
    func resolveStorageService() -> StorageService {
        if self.storageService == nil {
            var encryptionKey = RealmStorageService.getEncryptionKey(kcWrapper: self.kcWrapper, keychainAlias: self.REALM_STORAGE_KEYCHAIN_ALIAS)
            self.storageService = RealmStorageService(kcWrapper: self.kcWrapper, encryptionKey: encryptionKey!)
            // nullify key
            encryptionKey = nil
        }
        return self.storageService!
    }

    func resolveDeviceTrustService() -> DeviceTrustService {
        if self.deviceTrustService == nil {
            self.deviceTrustService = iosDeviceTrustService()
        }
        return self.deviceTrustService!
    }
}
