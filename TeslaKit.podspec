#
# Be sure to run `pod lib lint TeslaKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TeslaKit'
  s.version          = '2.3.2'
  s.summary          = 'TeslaKit is a framework written in Swift that makes it easy for you to interface with Tesla’s mobile API and communicate with your Tesla vehicles'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TeslaKit is a framework written in Swift that makes it easy for you to interface with Tesla’s mobile API and communicate with your Tesla vehicles'

  s.homepage         = 'https://github.com/HamblinSoft/TeslaKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jjjjaren' => 'jjjjaren@gmail.com' }
  s.source           = { :git => 'https://github.com/HamblinSoft/TeslaKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '4.0'
  s.tvos.deployment_target = '11.0'

  s.source_files = 'Source/**/*'
  
  # s.resource_bundles = {
  #   'TeslaKit' => ['Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ObjectMapper', '~> 3.3'
end
