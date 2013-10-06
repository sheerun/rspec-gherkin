require "rspec-gherkin/builder"
require "rspec-gherkin/dsl"
require "rspec-gherkin/execute"
require "rspec-gherkin/rspec"
require "rspec-gherkin/version"

module RspecGherkin
  class Pending < StandardError; end
  class Ambiguous < StandardError; end

  class << self
    attr_accessor :type
  end
end

RspecGherkin.type = :feature

self.extend RspecGherkin::DSL::Global

::RSpec.configure do |config|
  config.pattern << ",**/*.feature"
  config.extend RspecGherkin::DSL::Rspec
end

::RSpec::Core::Configuration.send(:include, RspecGherkin::RSpec::Loader)
