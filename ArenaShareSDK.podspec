#
# Be sure to run `pod lib lint ArenaShareSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ArenaShareSDK'
  s.version          = '1.0.5'
  s.summary          = 'Arena集成友盟分享的SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      集成友盟分享
                       DESC

  s.homepage         = 'https://github.com/zhang382847657/arenaShareSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '为毛哩' => '382847657@qq.com' }
  s.source           = { :git => 'https://github.com/zhang382847657/arenaShareSDK.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'ArenaShareSDK/Classes/**/*'

  s.frameworks = 'CoreTelephony','SystemConfiguration','CoreGraphics','UIKit','Foundation'
  s.libraries = 'z','sqlite3','c++'

  s.vendored_frameworks = 'Frameworks/*'
  s.vendored_libraries = 'Libraries/*'
  s.resource = 'Resources/*','*.plist'

end
