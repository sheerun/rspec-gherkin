Feature: Notification of update to specification
  As a tester of software
  I want to be updated when the specification changes
  so that I can ensure that we are accurately testing the current specs

  Scenario: recognizes and notifies when feature is marked as @updated
    Given a gherkin feature is tagged @updated
    When I run the spec
    Then I am notified that the feature has been updated

  Scenario: recognizes and notifies when scenario is marked as @updated
    Given a gherkin scenario is tagged @updated
    When I run the spec
    Then I am notified that the scenario has been updated

