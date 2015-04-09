require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:features) do |t|
  STDOUT.puts ''
  STDOUT.puts 'Running Acceptance Test Suite'
  sh 'rspec features'
end


RSpec::Core::RakeTask.new(:spec) do |t|
  ENV['SPEC'] = 'spec'
  STDOUT.puts ''
  STDOUT.puts 'Running Unit Test Suite'
  t.rspec_opts= '-t unit'
end

task :full_test => [:spec, :features]

if ENV['TRAVIS']
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new

  task :full_test => [:spec, :features, 'coveralls:push']
end

