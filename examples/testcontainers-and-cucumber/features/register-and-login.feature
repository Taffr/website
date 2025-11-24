Feature: Register and Login
  As a new user
  I want to register and login
  So that I can maintain a session

  Background:
    Given I register a new user with 
      | email              | password |
      | exists@example.com | hunter2  |

  Scenario: Successfully register a new user
    When I register a new user with 
      | email            | password |
      | test@example.com | hunter2  |
    Then I have successfully registered

  Scenario: User E-mail conflict
    When I register a new user with 
      | email            | password |
      | exists@example.com | hunter2  |
    Then I am made aware that the user is already registered

  Scenario: Login with unregistered user
    When I login with email "test@example.com" and password "hunter2"
    Then I am denied

  Scenario: Successful login
    When I login with email "exists@example.com" and password "hunter2"
    Then I am logged in
