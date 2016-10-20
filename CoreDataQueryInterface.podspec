Pod::Spec.new do |s|
  s.name = 'CoreDataQueryInterface'
  s.version = '5.0'
  s.license = 'MIT'
  s.summary = 'A type-safe, fluent Swift library for working with Core Data.'
  s.homepage = 'https://github.com/Prosumma/CoreDataQueryInterface'
  s.social_media_url = 'http://twitter.com/prosumma'
  s.authors = { 'Gregory Higley' => 'code@revolucent.net' }
  s.source = { :git => "#{s.homepage}.git", :tag => "v#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'CoreDataQueryInterface/*.swift'
  s.requires_arc = true
end
