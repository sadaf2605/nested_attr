$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nested_attr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nested_attr"
  s.version     = NestedAttr::VERSION
  s.authors     = ["Sadaf Noor"]
  s.email       = ["sadaf2605@gmail.com"]
  s.homepage    = "https://github.com/sadaf2605/nested_attr"
  s.summary     = "Using this plugin you can use Factory Girl to test your formastic forms like that of active admin without much hassle."
  s.description = "Using this plugin you can use Factory Girl to test your formastic forms like that of active admin without much hassle."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "factory_girl"

# s.add_development_dependency "sqlite3"
end
