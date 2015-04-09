feature 'Unimplemented features' do
  before(:all) do
    @result = %x(rspec example_project/spec --tag feature --format documentation 2>&1)
  end

  scenario 'unimplemented scenario', wip: true do
    results = %x'rspec example_project/features/error_conditions/unimplemented_scenario.feature'
    expect(results).to include("No such scenario in 'features/error_conditions/unimplemented_scenario.feature")
  end

  scenario 'Running a feature without a spec implemented' do
    result = %x(rspec example_project/features/error_conditions/feature_without_spec_file.feature)
    expect(result).to include('No spec implemented for feature')
  end

  context 'non-existing scenario' do
    scenario 'Running a spec without corresponding scenario' do
      expect(@result).to include("Scenario: Non-existing scenario")
      expect(@result).to include("No such scenario in 'features/error_conditions/no_scenario.feature'")
      expect(@result).to include("/spec/features/error_conditions/no_scenario_spec.rb:2")
    end
  end

  context 'non-existing feature' do
    scenario 'shows name of non-existing feature' do
      expect(@result).to include("Feature: Missing feature")
    end

    scenario 'shows that spec implements non-existing feature' do
      expect(@result).to include("No such feature in 'features/error_conditions/no_feature.feature'")
      expect(@result).to include("/spec/features/error_conditions/no_feature_spec.rb:1")
    end
  end
end