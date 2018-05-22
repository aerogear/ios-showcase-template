# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ios-showcase-template' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  platform :ios, '10.0'

  if ENV['LOCAL_DIR']
    pod 'AGSCore', :path => ENV['LOCAL_DIR']
    pod 'AGSAuth', :path => ENV['LOCAL_DIR']
    pod 'AGSPush', :path => ENV['LOCAL_DIR']
    pod 'AGSSecurity', :path => ENV['LOCAL_DIR']
  else
    pod 'AGSAuth'
    pod 'AGSPush'
    pod 'AGSSecurity'
  end

  pod 'SwiftKeychainWrapper'
  pod 'NotificationBannerSwift'
  pod 'RealmSwift'
  pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git', :branch => 'master'
  pod 'Floaty', '~> 4.0.0'
  pod 'DTTJailbreakDetection'
  pod 'TrustKit'

  target 'ios-showcase-templateTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RealmSwift'
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
    end
end
