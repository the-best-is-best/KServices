#
# Be sure to run `pod lib lint KServices.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KServices'
  s.version          = '0.1.0'
  s.summary          = 'KServices for save or load data KeyChain.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "KServices for save or load data from KeyChain"

  s.homepage         = 'https://github.com/the-best-is-best/KServices'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors                  =  { 'the-best-is-best' => 'michelle.raouf@outlook.com' }
  s.source           = { :git => 'https://github.com/72160249/KServices.git', :tag => s.version.to_s
  s.swift_version            = '5.5'

  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'KServices/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KServices' => ['KServices/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
