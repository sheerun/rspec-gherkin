Feature: Unimplemented features
  As a tester of software
  I want feedback on features and scenarios that are not fully implemented
  so that I understand what I am testing

  #FIXME double check spec to test. Spec may be inaccurate.
  Scenario: unimplemented scenario
    Given I have a spec that does not implement a test for a scenario
    When I run the tests for the feature file
    Then I am warned that a test has not been written for that scenario

  Scenario: Running a feature without a spec implemented
    Given I have a feature without a spec implemented
    When I execute the test suite
    Then the feature is marked as pending
    And I am warned that a spec has not yet been implemented for this file

  Scenario: Running a spec without corresponding scenario
    Given a test without a corresponding spec
    When I execute the test suite
    Then I am informed there is no test for the spec
#  scenario 'shows name of non-existing scenario' do
#  expect(@result).to include("Scenario: Non-existing scenario")
#  end
#
#  scenario 'shows that spec implements non-existing scenario' do
#  expect(@result).to include("No such scenario in 'features/no_scenario.feature'")
#  expect(@result).to include("/spec/features/no_scenario_spec.rb:2")

  Scenario: shows name of non-existing feature
    Given a spec without a corresponding feature
    When I run the spec
    Then I am notified that there is a missing feature

  Scenario: shows that spec implements non-existing feature
    Given a spec file without a corresponding feature file
    When I run the spec
    Then I am notified that there is a missing feature
    And I see the line number of the spec