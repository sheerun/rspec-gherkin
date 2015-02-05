require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.root(File.expand_path(File.dirname(__FILE__) + '/..'))
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
end


require 'rspec-gherkin'
