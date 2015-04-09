require 'simplecov'
require 'coveralls'

if ENV['SPEC']
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter if ENV['TRAVIS']
  SimpleCov.root(File.expand_path(File.dirname(__FILE__) + '/..'))
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/features/'
  end
end