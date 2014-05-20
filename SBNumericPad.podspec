Pod::Spec.new do |s|
  s.name             	= "SBNumericPad"
  s.version          	= "0.1.0"
  s.summary          	= "Numeric keyboard in UIPopoverController for UITextFields."
  s.description      	= "Numeric keyboard in UIPopoverController for textFields inspired by ZenKeyboard (https://github.com/nickevin/ZenKeyboard)."
  s.homepage         	= "https://github.com/Bogdan-Stasjuk/SBNumericPad"
  s.license      		= { :type => 'MIT', :file => 'LICENSE' }
  s.author           	= { "Bogdan Stasjuk" => "Bogdan.Stasjuk@gmail.com" }
  s.source           	= { :git => "https://github.com/Bogdan-Stasjuk/SBNumericPad.git", :tag => '0.1.0' }
  s.social_media_url = 'https://twitter.com/Bogdan_Stasjuk'
  s.platform     		= :ios, '6.0'
  s.requires_arc 	= true
  s.source_files 	= 'SBNumericPad/*.{h,m}'
  s.public_header_files   	= 'SBNumericPad/*.h'
  s.ios.resource_bundle 	= { 'Resources' => 'SBNumericPad/SBNumericPadExamples/Resource/*.png' }
end
