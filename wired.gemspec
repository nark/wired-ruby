Gem::Specification.new do |s|
  s.name        = 'wired'
  s.version     = '0.0.2'
  s.date        = '2013-05-27'
  s.summary     = "Wired 2.0 implementation in Ruby"
  s.description = "This wired gem provides a Wired 2.0 implementation in Ruby"
  s.authors     = ["Rafaël Warnault"]
  s.email       = 'dev@read-write.fr'
  s.files 		  = Dir["{lib}/**/*", "[A-Z]*"]
  s.homepage    = 'http://wired.read-write.fr'
  s.license 	  = 'BSD-3-Clause'

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'nokogiri', '~> 1.5', '>= 1.5.5'
  s.add_development_dependency 'rspec', '~> 2.13', '>= 2.13.0'
  s.add_development_dependency 'timers', '~> 1.1', '>= 1.1.0'
  s.add_development_dependency 'logging', '~> 1.8', '>= 1.8.1'
  s.add_development_dependency 'deep_clone', '~> 0.0.1'
  s.add_development_dependency 'openssl', '~> 2.1.2'
  s.add_development_dependency 'zlib', '~> 1.0.0'
  s.add_development_dependency 'bindata', '~> 2.4.4'
  s.add_development_dependency 'pr-zlib', '~> 1.0.6'
end