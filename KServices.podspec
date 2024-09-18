#
# Be sure to run `pod lib lint KServices.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KServices'
  s.version          = '0.1.5'
  s.summary          = 'KServices for save or load data from KeyChain.'

  s.description = 'KServices provides functionality for saving and loading data from the iOS Keychain. It includes methods for securely storing and retrieving data such as user credentials and sensitive information.'
  s.homepage         = 'https://github.com/the-best-is-best/KServices'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'the-best-is-best' => 'michelle.raouf@outlook.com' }
  s.source           = { :git => 'https://github.com/the-best-is-best/KServices.git', :tag => s.version.to_s }
  s.swift_version    = '5.5'
  s.ios.deployment_target = '12.0'

  s.source_files     = 'KServices/Classes/**/*'
  s.ios.frameworks   = 'UIKit'
end
