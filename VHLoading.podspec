Pod::Spec.new do |spec|

  spec.name         = "VHLoading"
  spec.version      = "1.0.0"
  spec.summary      = "VHLoading is a simple loading animation library written in Swift."

  spec.homepage     = "https://github.com/vidalhara/VHLoading"

  spec.license      = "MIT"

  spec.author       = "Vidal HARA"
  spec.documentation_url = 'https://vidalhara.github.io/VHLoading/'
  
  spec.ios.deployment_target = '12.0'
  spec.swift_versions = ['4.0', '5.1', '5.2', '5.3', '5.4', '5.5']

  spec.source       = { :git => "https://github.com/vidalhara/VHLoading.git", :tag => spec.version.to_s }
  
  spec.source_files = "VHLoading/**/*.swift"
  spec.frameworks = "UIKit"
end
