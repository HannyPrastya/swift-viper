# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!

def shared_pods
#  Reactive Programming
  pod 'RxSwift'
  pod 'RxCocoa'
  
#  DI
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
end

target 'Challenge' do
  shared_pods
  pod 'Alamofire'
  
#  Reactive Community
  pod "RxGesture"

  target 'ChallengeTests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'Nimble'
    pod 'Quick'
  end
end

