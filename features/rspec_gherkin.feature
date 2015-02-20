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

   Scenario: unimplemented scenario
     Given I have a spec that does not implement a test for a scenario
     When I run the tests for the feature file
     Then I am warned that a test has not been written for that scenario

  Scenario: Run with ~type:feature against features directory
    Given I have passed in the parameter ~type:feature
    When I execute the test suite against the features directory
    Then tests with type:feature are included in the test suite

  Scenario: Running a feature without a spec implemented
    Given I have a feature without a spec implemented
    When I execute the test suite
    Then the feature is marked as pending
    And I am warned that a spec has not yet been implemented for this file

