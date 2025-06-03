Pod::Spec.new do |s|
  s.name             = 'PHInfoManager'
  s.version          = '1.0.0'
  s.summary          = 'Binary-only XCFramework for device info'
  s.description      = 'This is a precompiled binary framework for internal use. No source code exposed.'
  s.homepage         = 'https://github.com/kandaofu/PHInfoManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kandaofu' => '18756961431@163.com' }
  s.platform         = :ios, '13.0'

  s.source           = { :git => 'https://github.com/kandaofu/PHInfoManager.git', :tag => s.version.to_s }
  s.vendored_frameworks = 'PHInfoManager.xcframework'
  s.preserve_paths = 'PHInfoManager.xcframework'
end