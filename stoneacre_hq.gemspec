$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stoneacre_hq/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stoneacre_hq"
  s.version     = StoneacreHq::VERSION
  s.authors     = ["Carla Pamela Ares"]
  s.email       = ["carla@xagax.com"]
  s.homepage    = "http://affinitystop.com"
  s.summary     = "Summary for affinitystop.com"
  s.description = "Description for affinitystop.com"

  # documentation
  s.has_rdoc = true
  s.extra_rdoc_files = %w( README.rdoc )
  s.rdoc_options = %w( --main README.rdoc )

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
end
