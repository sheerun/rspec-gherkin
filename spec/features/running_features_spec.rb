require_relative '../spec_helper'

feature 'RSpec gherkin test runner' do
  before(:all) do
    @result = %x(rspec example_project/spec --tag feature --format documentation 2>&1)
  end

  scenario 'running a feature file' do
    result = %x(rspec example_project/features/simple_feature.feature --format j)
    expect(test_results(result)).to include('4 examples, 1 failure')
  end

  scenario 'running a spec file' do
    result = %x(rspec example_project/spec/features/simple_feature_spec.rb)
    expect(test_results(result)).to include('4 examples, 1 failure')
  end

  #FIXME should this be 10 or 11?
  scenario 'summary of tests' do
    expect(test_results(@result)).to include('10 examples, 1 failure, 5 pending')
  end

  #TODO evaluate whether this behavior is beneficial
  scenario 'Run with ~type:feature against features directory' do
    result = %x(rspec example_project/features --tag ~feature)
    expect(test_results(result)).to include('11 examples, 1 failure, 5 pending')
  end

  scenario 'ignores --tag ~type:feature flag when running features' do
    result = %x(rspec example_project/features --tag ~type:feature )
    expect(test_results(result)).to include('11 examples, 1 failure, 5 pending')
  end

  scenario 'prepends features with "Feature: " prefix' do
    expect(@result).to include('Feature: A simple feature')
  end

  scenario 'prepends scenarios with "Scenario: " prefix' do
    expect(@result).to include('Scenario: A simple scenario')
  end

  #TODO establish if these scenarios provided value, and if so, fix them
  # scenario "Shows feature description" do
  #   @result.should include('A simple feature')
  #   @result.should include('is a simple feature')
  # end
  #
  # scenario "Shows summary of tests" do
  #   expect(test_results(@result)).to include('35 examples, 3 failures, 5 pending')
  # end
  #
  # scenario "Feature file is included in failure backtraces" do
  #   @result.should include('examples/errors.feature:5:in `raise error')
  # end
  #
  # scenario "Shows the \"correct\" step name for nested steps" do
  #   @result.should include("No such step: 'this is an unimplemented step'")
  # end

end