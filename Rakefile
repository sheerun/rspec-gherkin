require "bundler/gem_tasks"

#Simplecov setup
if ENV['SIMPLECOV']
  begin
    require 'simplecov'
    puts 'using simple cov'
    SimpleCov.root(File.expand_path(File.dirname(__FILE__) + '/..'))
    SimpleCov.start
  end
else
  require 'coveralls'
  Coveralls.wear!
end


task :console do
  require 'irb'
  require 'irb/completion'
  require 'rspec-gherkin'
  ARGV.clear
  IRB.start
end


require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:features) do |t|
  STDOUT.puts ''
  STDOUT.puts 'Running Acceptance Test Suite'
  t.pattern= 'features'
  t.rspec_opts= '--color -f d'
end

RSpec::Core::RakeTask.new(:specs) do |t|
  STDOUT.puts ''
  STDOUT.puts 'Running Unit Test Suite'
  t.pattern= 'spec'
end

task :full_test => [:specs, :features]


