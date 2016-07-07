#
# Be sure to run `pod lib lint Datasnap.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Datasnap'
s.version          = 'v2.0.0'
s.summary          = 'The new Datasnap iOS SDK.'

s.description      = <<-DESC
Insight from proximity-triggered engagement through meticulous measurement; predictive analytics; and rich, responsive visualization.
DESC

s.homepage         = 'https://github.com/datasnap-io/datasnap-ios-sdk'
s.license          = { :type => 'APACHE, version 2.0', :file => 'LICENSE' }
s.author           = { 'Layne McIntyre' => 'amcintyre@grio.com' }
s.source           = { :git => 'https://github.com/datasnap-io/datasnap-ios-sdk.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'Datasnap/Classes/{Event Properties,Event Types,Model,Utilities}/*.{c,h,hh,m,mm}'
s.frameworks = 'CoreData'
s.resources      = 'Datasnap/Classes/**/*.{xcdatamodeld,xcdatamodel}'
s.dependency 'AFNetworking'
s.default_subspec = 'Generic'
s.subspec 'Generic' do |generic|
# subspec for users who don't want the third party Gimbal bloat
end
s.subspec 'Gimbal' do |gimbal|
gimbal.dependency 'Gimbal'
gimbal.source_files = 'Datasnap/Classes/Gimbal/*.{h,m}'
end
end
