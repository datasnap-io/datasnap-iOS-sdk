#
# Be sure to run `pod lib lint Datasnap.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Datasnap'
s.version          = '1.0.4'
s.summary          = 'The new Datasnap iOS SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Insight from proximity-triggered engagement through meticulous measurement; predictive analytics; and rich, responsive visualization.
DESC

s.homepage         = 'https://github.com/datasnap-io/datasnap-ios-sdk'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'APACHE, version 2.0', :file => 'LICENSE' }
s.author           = { 'Layne McIntyre' => 'amcintyre@grio.com' }
s.source           = { :git => 'https://github.com/datasnap-io/datasnap-ios-sdk.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'Datasnap/Classes/{Event Properties,Event Types,Model,Utilities}/*.{c,h,hh,m,mm}'

# s.resource_bundles = {
#   'Datasnap' => ['Datasnap/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'CoreData'
s.resources      = 'Datasnap/Classes/**/*.{xcdatamodeld,xcdatamodel}'
s.dependency 'AFNetworking'
s.default_subspec = 'Gimbal'
s.subspec 'Generic' do |generic|
# subspec for users who don't want the third party Gimbal bloat
end
s.subspec 'Gimbal' do |gimbal|
gimbal.dependency 'Gimbal'
gimbal.source_files = 'Datasnap/Classes/Gimbal/*.{h,m}'
end
end
