platform :ios, '9.0'

target 'ShowcaseTemplate' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShowcaseTemplate
  # Should contain each individual mobile services
  if ENV['LOCAL']
    pod 'AGSAuth', :path => '../'
    pod 'AGSPush', :path => '../'
  else
    pod 'AGSAuth'
    pod 'AGSPush'
  end

  pod 'SwiftKeychainWrapper'
  pod 'Alamofire', '~> 4.5'
  pod 'NotificationBannerSwift'
  pod 'RealmSwift'
  pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git', :branch => 'master'
  pod 'Floaty', '~> 4.0.0'
  pod 'DTTJailbreakDetection'
  pod 'TrustKit'
end