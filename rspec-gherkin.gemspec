# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "rspec-gherkin/version"

Gem::Specification.new do |s|
  s.name        = "rspec-gherkin"
  s.version     = RSpecGherkin::VERSION
  s.authors     = ["Adam Stankiewicz"]
  s.email       = ["sheerun@sher.pl"]
  s.homepage    = ""
  s.summary     = %q{Different approach to Gherkin features in RSpec}
  s.description = %q{Different approach to Gherkin features in RSpec}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rspec", "~> 2.0"
  s.add_runtime_dependency "gherkin", ">= 2.5"
  s.add_runtime_dependency "capybara", "~> 2.0"
  s.add_development_dependency "rake"
end
