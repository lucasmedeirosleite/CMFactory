Pod::Spec.new do |s|
  s.name         = "CMFactory"
  s.version      = "1.4.2"
  s.summary      = "FactoryGirl and fixture loader for iOS."
  s.homepage     = "https://github.com/lucasmedeirosleite/CMFactory"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Lucas Medeiros" => "lucastoc@gmail.com" }

  s.source       = { :git => "https://github.com/lucasmedeirosleite/CMFactory.git", tag: s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'CMFactoryExampleTests/CMFactory'

  s.xcconfig  = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }

  s.dependency 'Mantle', '~> 1.5.4'

end
