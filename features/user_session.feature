@github-web
Feature: User sessions

  Scenario: Signing in for the first time
    Given I have a github account
    And I have never logged in
    When I try to login
    And I allow the app to do actions on my behalf
    Then I should be registered
    And I should be logged in

  Scenario: Coming back
    Given I have an octopub account
    When I try to login
    Then I should be logged in
