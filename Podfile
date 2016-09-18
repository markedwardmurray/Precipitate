# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'Precipitate' do
  pod 'Alamofire', '~> 3.5.0'
  pod 'Charts', :git => 'https://github.com/danielgindi/Charts', :branch => 'Swift-2.3'
  pod 'FontAwesome.swift', :git => 'https://github.com/thii/FontAwesome.swift', :branch => 'swift-2.3'
  pod 'INTULocationManager', '~> 4.2.0'
  pod 'MarqueeLabel', '~> 2.7.10'
  pod 'SnapKit', '~> 0.22.0'
  pod 'SwiftHEXColors', '~> 1.0.4'
  pod 'SwiftyDate', '~> 1.0.1'
  pod 'SwiftyJSON', '~> 2.3.2'
  pod 'SwiftyUserDefaults', '~> 2.2.1'
end

target 'PrecipitateTests' do
  pod 'Quick', '~> 0.9.3'
  pod 'Nimble', '~> 4.1.0'
  pod 'Nimble-Snapshots', '~> 4.1.0'
  pod 'KIF', '~> 3.4.2'
  pod 'FBSnapshotTestCase', '~> 2.1.1'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
