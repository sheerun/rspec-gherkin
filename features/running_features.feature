Feature: RSpec gherkin test runner
  As an acceptance tester of software
  I want to run specs tied to gherkin
  In order to validate that acceptance criteria have been met

  Scenario: running a feature file
    Given I have a feature file
    When I pass in that filepath to rspec
    Then the corresponding spec is run

  Scenario: running a spec file
    Given I have a spec file
    When I pass that filepath to rspec
    Then the spec is run

  Scenario: summary of tests
    When I execute the test suite
    Then I see a summary of the results of all tests that were run

  Scenario: Run with ~type:feature against features directory
    Given I have passed in the parameter ~type:feature
    When I execute the test suite against the features directory
    Then tests with type:feature are included in the test suite

  Scenario: ignores --tag ~type:feature flag when running features
    Given I have passed the parameter --tag ~type:feature
    When I execute the test suite against the features directory
    Then tests with type:feature are included in the test suite

  Scenario: prepends features with "Feature: " prefix
    When I execute the test suite
    Then features are prepended with "Feature: "

  Scenario: prepends scenarios with "Scenario: " prefix
    When I execute the test suite
    Then scenarios are prepended with "Scenario: "

  #TODO establish if these scenarios provided value and if so make them pass again
#  Scenario: Shows feature description
#    When I execute the test suite
#    Then features display their description
#
#  Scenario: Shows summary of tests
#    When I execute the test suite
#    Then the summary of tests, failures, and pending is displayed
#
#  Scenario: Feature file is included in failure backtraces
#    When a test fails
#    Then the feature for the test is included in the backtrace of the failure
#
#    #FIXME this is bad and I should feel bad
#  Scenario: Shows the "correct" step name for nested steps
#    When I execute a test that uses nested steps
#    Then I see the "correct" name for the step