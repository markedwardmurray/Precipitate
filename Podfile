# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

def testing_pods
  pod 'Quick', '~> 0.8.0'
  pod 'Nimble', '~> 3.0.0'
  pod 'Nimble-Snapshots', '~> 3.0.0'
  pod 'KIF', '~> 3.3.0'
  pod 'FBSnapshotTestCase', '~> 2.0.7'
end

target 'Precipitate' do
  pod 'Alamofire', '~> 3.1.3'
  pod 'Charts', '~> 2.1.6'
  pod 'ForecastIO'
  pod 'INTULocationManager', '~> 4.1.1'
  pod 'SwiftyJSON'
end

target 'PrecipitateTests' do
  testing_pods
end

target 'PrecipitateUITests' do
  testing_pods
end

