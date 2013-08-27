Gem::Specification.new do |s|
  s.name        = 'wired'
  s.version     = '0.0.1'
  s.date        = '2013-05-27'
  s.summary     = "Wired 2.0 implementation in Ruby"
  s.description = "This wired gem provides a Wired 2.0 implementation in Ruby"
  s.authors     = ["Rafaël Warnault"]
  s.email       = 'dev@read-write.fr'
  s.files 		= Dir["{lib}/**/*", "[A-Z]*"]
  s.homepage    = 'http://wired.read-write.fr'
  s.license 	= 'BSD'

  s.required_ruby_version = '>= 1.9.2'

  s.add_development_dependency('nokogiri', '~> 1.5.5')
  s.add_development_dependency('xml-simple', '~> 1.1.2')
  s.add_development_dependency('rspec', '~> 2.13.0')
  s.add_development_dependency('timers', '~> 1.1.0')
end