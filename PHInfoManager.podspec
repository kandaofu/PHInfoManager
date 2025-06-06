Pod::Spec.new do |s|
  s.name             = 'PHInfoManager'
  s.version          = '1.0.4'
  s.summary          = 'Binary-only XCFramework for device info.'
  s.description      = <<-DESC
    A binary-only precompiled framework for retrieving iOS device information.
  DESC
  s.homepage         = 'https://github.com/kandaofu/PHInfoManager'
  s.license = { :type => 'Proprietary', :text => 'Binary-only internal distribution. All rights reserved.' }
  s.author           = { 'kandaofu' => '' }
  s.platform         = :ios, '13.0'

  s.source = {
    :http => 'https://github.com/kandaofu/PHInfoManager/releases/download/1.0.4/PHInfoManager.xcframework.zip'
  }

  s.vendored_frameworks = 'PHInfoManager.xcframework'
  s.static_framework = true
  s.preserve_paths = 'PHInfoManager.xcframework'

end