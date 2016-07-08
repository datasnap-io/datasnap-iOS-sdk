Pod::Spec.new do |s|
s.name             = 'Datasnap'
s.version          = '2.0.0'
s.summary          = 'The new Datasnap iOS SDK.'

s.description      = <<-DESC
Insight from proximity-triggered engagement through meticulous measurement; predictive analytics; and rich, responsive visualization.
DESC

s.homepage         = 'https://github.com/datasnap-io/datasnap-ios-sdk'
s.license          = { :type => 'APACHE, version 2.0', :file => 'LICENSE' }
s.author           = { 'Layne McIntyre' => 'amcintyre@grio.com' }
s.source           = { :git => 'https://github.com/datasnap-io/datasnap-ios-sdk.git', :commit => 'b000782' }

s.ios.deployment_target = '8.0'
s.resources = 'Datasnap/Classes/{Event Properties,Event Types,Model,Utilities}/*.{c,h,hh,m,mm}'
s.source_files = 'Datasnap/Classes/{Event Properties,Event Types,Model,Utilities}/*.{c,h,hh,m,mm}'
s.frameworks = 'CoreData'

s.dependency 'AFNetworking'
s.default_subspec = 'Generic'
s.subspec 'Generic' do |generic|
# subspec for users who don't want the third party Gimbal bloat
end
s.subspec 'Gimbal' do |gimbal|
gimbal.dependency 'Gimbal'
gimbal.source_files = 'Datasnap/Classes/**/*.{h,m}'
end
end
