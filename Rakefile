require 'bundler/gem_tasks'
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

if ENV['TRAVIS']
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new

  task :full_test => [:specs, :features, 'coveralls:push']
end

