load File.expand_path(File.dirname(__FILE__) + '/../spec/simplecov_setup.rb')

require 'rspec-gherkin'

def test_results output
  output[/\d+ examples?, \d+ failures?(, \d+ pending)?/]
end