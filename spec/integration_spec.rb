require 'spec_helper'

describe 'The CLI', :type => :integration do
  context 'runing features from features directory' do
    it 'ignores --tag ~feature flag when running features' do
      expect(%x(rspec features --tag ~feature 2>&1)).
        to include('5 examples, 1 failure, 2 pending')
    end

    it 'ignores --tag ~type:feature flag when running features' do
      expect(%x(rspec features --tag ~type:feature 2>&1)).
        to include('5 examples, 1 failure, 2 pending')
    end
  end

  context 'runing features specs on their own' do
    before(:all) do
      @result = %x(rspec --tag feature --format documentation 2>&1)
    end

    it 'passes all specs' do
      expect(@result).to include('5 examples, 1 failure, 2 pending')
    end

    it 'prepends features with "Feature: " prefix' do
      expect(@result).to include('Feature: A simple feature')
    end

    it 'prepends scenarios with "Scenario: " prefix' do
      expect(@result).to include('Scenario: A simple scenario')
    end

    context 'non-existing scenario' do
      it 'shows name of non-existing scenario' do
        expect(@result).to include(
          "Scenario: Non-existing scenario"
        )
      end

      it 'shows that spec implements non-existing scenario' do
        expect(@result).to include(
          "No such scenario in 'features/no_scenario.feature'"
        )
      end

      it 'shows line number where missing scenario is mentioned' do
        expect(@result).to include(
          "./spec/features/no_scenario_spec.rb:2"
        )
      end
    end

    context 'non-existing feature' do
      it 'shows name of non-existing feature' do
        expect(@result).to include(
          "Feature: Missing feature"
        )
      end

      it 'shows that spec implements non-existing feature' do
        expect(@result).to include(
          "No such feature in 'features/no_feature.feature'"
        )
      end

      it 'shows line number where missing scenario is mentioned' do
        expect(@result).to include(
          "./spec/features/no_feature_spec.rb:3"
        )
      end
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
