# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["John Barnette"]
  gem.email         = ["john@jbarnette.com"]
  gem.description   = "Move between domain models and data structures."
  gem.summary       = "Update attributes with impunity."
  gem.homepage      = "https://github.com/jbarnette/between"

  gem.files         = `git ls-files`.split "\n"
  gem.test_files    = `git ls-files -- test/*`.split "\n"
  gem.name          = "between"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.0"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "mocha"
end
