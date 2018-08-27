
Pod::Spec.new do |s|
  s.name             = "HSFLballPod"
  s.version          = "1.0.0"
  s.summary          = "HSFloatingBall for IOS."
  s.description      = <<-DESC
                       It is a FloatingBall used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/HandScapeIncDrive/HSFLballPod.git"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Yifan" => "yifan.chen@handscape.info" }
  s.source           = { :git => "/Users/yifan/Downloads/HandScape/Software/HSFLballPod/FloatingBall", :tag => s.version }

  s.platform     = :ios
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  #s.source_files = 'WZMarqueeView/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'HandScapeSDK.framework'

end