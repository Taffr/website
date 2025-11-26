Feature: Login
  Background:
    Given I register a new user with 
      | email              | password |
      | exists@example.com | hunter2  |

  Scenario: Login with unregistered user
    When I login with email "test@example.com" and password "supersecret"
    Then I am denied

  Scenario: Successful login
    When I login with email "exists@example.com" and password "hunter2"
    Then I am logged in
