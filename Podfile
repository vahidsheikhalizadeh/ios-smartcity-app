platform :ios, '9.0'

target 'smartCity' do

  use_frameworks!

  # Pods for smartCity
pod 'RealmSwift'
pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'SVProgressHUD'
pod 'ChameleonFramework'
# Pods for HTTP Networking
pod 'SwiftyJSON'
pod 'Alamofire'
# Reactive RxSwift
pod 'RxSwift'
pod 'RxCocoa'
pod 'RxAlamofire'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
