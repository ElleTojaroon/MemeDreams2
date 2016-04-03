# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

# https://github.com/CocoaPods/CocoaPods/issues/4420

use_frameworks!

target ‘TotoesGoats’ do
    pod 'RealmSwift'
    pod 'RealmMapView'
    pod 'Alamofire'
    pod 'SwiftyJSON' #, :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
end

post_install do |installer|
    `rm -rf Pods/Headers`
end

