Pod::Spec.new do |s|
  s.name             = "Anchorage"
  s.version          = "4.3.1"
  s.summary          = "A collection of operators and utilities that simplify iOS layout code."
  s.description      = <<-DESC
                       Create constraints using intuitive operators built directly on top of the NSLayoutAnchor API. Layout has never been simpler!
                       DESC
  s.homepage         = "https://github.com/Rightpoint/Anchorage"
  s.license          = 'MIT'
  s.author           = { "Rob Visentin" => "jvisenti@gmail.com" }
  s.source           = { :git => "https://github.com/Rightpoint/Anchorage.git", :tag => s.version.to_s }
  s.swift_versions    = ['4.0', '4.2', '5.0']

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.requires_arc = true

  s.source_files = "Source/**/*.swift"
end
