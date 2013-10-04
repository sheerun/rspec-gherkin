require "rspec-gherkin/version"
require "rspec-gherkin/dsl"
require "rspec-gherkin/execute"
require "rspec-gherkin/define"
require "rspec-gherkin/builder"
require "rspec-gherkin/step_definition"
require "rspec-gherkin/placeholder"
require "rspec-gherkin/table"

module RspecGherkin
  class Pending < StandardError; end
  class Ambiguous < StandardError; end

  ##
  #
  # The global step module, adding steps here will make them available in all
  # your tests.
  #
  module Steps
  end

  class << self
    attr_accessor :type
  end
end

RspecGherkin.type = :feature

Module.send(:include, RspecGherkin::Define)

self.extend RspecGherkin::DSL

require "rspec-gherkin/rspec"
