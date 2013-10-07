require 'spec_helper'

describe 'The CLI', :type => :integration do
  context 'runing features from features directory' do
    it 'ignores --tag ~feature flag when running features' do
      expect(%x(rspec features --tag ~feature 2>&1).each_line.to_a.last).
        to include('19 examples, 0 failures, 17 pending')
    end

    it 'ignores --tag ~type:feature flag when running features' do
      expect(%x(rspec features --tag ~type:feature 2>&1).each_line.to_a.last).
        to include('19 examples, 0 failures, 17 pending')
    end
  end

  context 'runing features specs on their own' do
    before(:all) do
      @result = %x(rspec --tag feature --format documentation 2>&1)
    end

    it 'prepends features with "Feature: " prefix' do
      expect(@result).to include('Feature: A simple feature')
    end

    it 'prepends scenarios with "Scenario: " prefix' do
      expect(@result).to include('Scenario: A simple scenario')
    end

    it 'shows that spec implements non-existing scenario' do
      expect(@result).to include("No matching scenario: 'Non-existing scenario'")
    end

    it 'passes all specs' do
      expect(@result).to include('4 examples, 0 failures')
    end
  end

  # it "shows the correct description" do
  #   @result.should include('A simple feature')
  #   @result.should include('is a simple feature')
  # end

  # it "prints out failures and successes" do
  #   @result.should include('35 examples, 3 failures, 5 pending')
  # end

  # it "includes features in backtraces" do
  #   @result.should include('examples/errors.feature:5:in `raise error')
  # end

  # it "includes the right step name when steps call steps" do
  #   @result.should include("No such step: 'this is an unimplemented step'")
  # end
end
