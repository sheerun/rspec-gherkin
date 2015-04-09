@updated
Feature: Updated feature
  Scenario: Attack a monster with cool tag
    Given there is a monster
    When I attack it
    Then it should die

  Scenario: Attack another monster
    Given there is a strong monster
    When I attack it
    And I attack it
    Then it should die
