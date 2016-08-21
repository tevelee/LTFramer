Pod::Spec.new do |s|
  s.name             = 'LTFramer'
  s.version          = '1.0'
  s.summary          = 'LTFramer is a layout helper library to help setting frames of views using human-friendly syntax.'

  s.description      = <<-DESC
LTFramer helps setting frames of views and layers using simple human-readable syntax.
It contains convenience methods to help you create absolute and relative layouts.
DESC

  s.homepage         = 'https://github.com/tevelee/LTFramer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Laszlo Teveli' => 'tevelee@gmail.com' }
  s.source           = { :git => 'https://github.com/tevelee/LTFramer.git', :tag => s.version.to_s }

  s.header_dir = s.name
  s.module_name = s.name
  s.default_subspec = 'Core'
  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |ss|
    ss.source_files = 'LTFramer/Core/Common/**/*'
    ss.public_header_files = 'LTFramer/Core/Common/Public/**/*.h'
    ss.frameworks = 'Foundation'
    
    ss.ios.source_files = 'LTFramer/Core/iOS/**/*'
    ss.ios.public_header_files = 'LTFramer/Core/iOS/Public/**/*.h'
    ss.ios.frameworks = 'UIKit'
  end

  s.subspec 'Convenience' do |ss|
    ss.source_files = 'LTFramer/Convenience/Common/**/*'
    ss.public_header_files = 'LTFramer/Convenience/Common/Public/**/*.h'

    ss.ios.source_files = 'LTFramer/Convenience/iOS/**/*'
    ss.ios.public_header_files = 'LTFramer/Convenience/iOS/Public/**/*.h'
  end

  s.subspec 'Stack' do |ss|
    ss.dependency 'LTFramer/Core'
    ss.source_files = 'LTFramer/Stack/Common/**/*'
    ss.public_header_files = 'LTFramer/Stack/Common/Public/**/*.h'

    ss.ios.source_files = 'LTFramer/Stack/iOS/**/*'
    ss.ios.public_header_files = 'LTFramer/Stack/iOS/Public/**/*.h'
  end
end
