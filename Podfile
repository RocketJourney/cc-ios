# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'ControlCenter' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Alamofire'
  pod 'Branch'
  pod 'Crashlytics'
  pod 'Fabric'  
  pod 'Permission'  
  pod 'Permission/Notifications'
  pod 'ReachabilitySwift'
  pod 'RealmSwift'
  pod 'SideMenu', '5.0.0'
  pod 'SDWebImage'
  pod 'SnapKit'
  pod 'SVProgressHUD'
  pod 'SwiftHEXColors'
  pod 'SwiftyJSON'
  pod 'UIScrollView-InfiniteScroll'
  

  # Pods for ControlCenter

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end
