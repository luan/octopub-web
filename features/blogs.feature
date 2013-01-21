Feature: Blogs

  Background:
    Given I have an octopub account
    And I have no repositories called "octopub-test-blog"

  Scenario: Creating a new blog
    When I create a blog named "Octopub Test Blog"
    Then I should have an octopress clone called "octopub-test-blog"
