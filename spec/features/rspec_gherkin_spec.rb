feature 'RSpec gherkin test runner' do

    scenario 'Run with ~type:feature against features directory' do
      expect(%x(rspec example_project/features --tag ~feature)).to include('10 examples, 1 failure, 4 pending')
    end

  scenario 'Running a feature without a spec implemented' do
    expect(%x(rspec example_project/features/feature_without_spec_file.feature)).to include('No spec implemented for feature')
  end
#
#     scenario 'ignores --tag ~type:feature flag when running features' do
#       expect(%x(rspec features --tag ~type:feature 2>&1)).to include('9 examples, 1 failure, 3 pending')
#     end
#   end
#
#   context 'running features specs on their own' do
#     before(:all) do
#       @result = %x(rspec --tag feature --format documentation 2>&1)
#     end
#
#     scenario 'passes all specs' do
#       expect(@result).to include('9 examples, 1 failure, 4 pending')
#     end
#
#     scenario 'prepends features with "Feature: " prefix' do
#       expect(@result).to include('Feature: A simple feature')
#     end
#
#     scenario 'prepends scenarios with "Scenario: " prefix' do
#       expect(@result).to include('Scenario: A simple scenario')
#     end
#
#     context 'non-existing scenario' do
#       scenario 'shows name of non-existing scenario' do
#         expect(@result).to include("Scenario: Non-existing scenario")
#       end
#
#       scenario 'shows that spec implements non-existing scenario' do
#         expect(@result).to include("No such scenario in 'features/no_scenario.feature'")
#       end
#
#       scenario 'shows line number where missing scenario is mentioned' do
#         expect(@result).to include("/spec/features/no_scenario_spec.rb:2")
#       end
#     end
#
#     context 'non-existing feature' do
#       scenario 'shows name of non-existing feature' do
#         expect(@result).to include("Feature: Missing feature")
#       end
#
#       scenario 'shows that spec implements non-existing feature' do
#         expect(@result).to include("No such feature in 'features/no_feature.feature'")
#       end
#
#       scenario 'shows line number where missing scenario is mentioned' do
#         expect(@result).to include("/spec/features/no_feature_spec.rb:3")
#       end
#     end
#
#     context 'updated features and scenarios' do
#       scenario 'recognizes and notifies when feature is marked as @updated' do
#         expect(@result).to include('Feature has been marked as updated')
#       end
#
#       scenario 'recognizes and notifies when scenario is marked as @updated' do
#         expect(@result).to include('Scenario has been marked as updated')
#       end
#     end
#   end
#
#   # it "shows the correct description" do
#   #   @result.should include('A simple feature')
#   #   @result.should include('is a simple feature')
#   # end
#
#   # it "prints out failures and successes" do
#   #   @result.should include('35 examples, 3 failures, 5 pending')
#   # end
#
#   # it "includes features in backtraces" do
#   #   @result.should include('examples/errors.feature:5:in `raise error')
#   # end
#
#   # it "includes the right step name when steps call steps" do
  #   @result.should include("No such step: 'this is an unimplemented step'")
end
