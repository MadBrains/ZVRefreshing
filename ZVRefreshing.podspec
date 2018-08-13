#
#  Be sure to run `pod spec lint ZVRefreshing.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZVRefreshing"
  s.version      = "2.0.4"
  s.summary      = "A pure-swift and wieldy refresh component."
  s.description  = <<-DESC
  					ZRefreshing is a pure-swift and wieldy refresh component.
                   DESC

  s.homepage     = "https://github.com/zevwings/ZVRefreshing"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zevwings" => "zev.wings@gmail.com" }
  s.source       = { :git => "https://github.com/zevwings/ZVRefreshing.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.subspec 'Core' do |core|
    core.source_files = "ZVRefreshing/Base/**/*.swift", "ZVRefreshing/State/**/*.swift", "ZVRefreshing/Support/**/*.swift", "ZVRefreshing/ZVRefreshing.h"
    core.resources    = "ZVRefreshing/Resource/Localized.bundle"
  end

  s.subspec 'Flat' do |flat| 
    flat.source_files = "ZVRefreshing/Flat/**/*.swift"
    flat.dependency 'ZVRefreshing/Core'
    flat.dependency 'ZVActivityIndicatorView'
  end

  s.subspec 'Native' do |native|
    native.source_files = "ZVRefreshing/Native/**/*.swift"
    native.resources    = "ZVRefreshing/Resource/Image.bundle"
    native.dependency 'ZVRefreshing/Core'
  end

  s.subspec 'Animation' do |animation|
    animation.source_files = "ZVRefreshing/Animation/**/*.swift"
    animation.dependency 'ZVRefreshing/Core'
  end

end
