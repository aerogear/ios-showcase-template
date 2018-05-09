platform :ios, '9.0'

target 'AeroGearSdkExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AeroGearSdkExample
  # Should contain each individual mobile services
  pod 'AGSCore', :path => '../'
  if ENV['LOCAL']
    pod 'AGSAuth', :path => '../'
    pod 'AGSPush', :path => '../'
  else
    pod 'AGSAuth'
    pod 'AGSPush'
  end

  target 'AeroGearSdkExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AeroGearSdkExampleIntegrationTests' do
    inherit! :search_paths
    # Pods for testing
  end
end