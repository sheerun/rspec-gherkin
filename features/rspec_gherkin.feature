Feature: RSpec gherkin test runner
  As an acceptance tester of software
  I want to run specs tied to gherkin
  In order to validate that acceptance criteria have been met

  Scenario: Run with ~type:feature against features directory
    Given I have passed in the parameter ~type:feature
    When I execute the test suite against the features directory
    Then tests with type:feature are included in the test suite


  Scenario: Running a feature without a spec implemented
    Given I have a feature without a spec implemented
    When I execute the test suite
    Then the feature is marked as pending
    And I am warned that a spec has not yet been implemented for this file

