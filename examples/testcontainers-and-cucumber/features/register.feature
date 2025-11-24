Feature: Register
  Scenario: Successfully register a new user
    When I register a new user with 
      | email            | password |
      | test@example.com | hunter2  |
    Then I have successfully registered

  Scenario: User E-mail conflict
    Given I register a new user with 
      | email              | password |
      | exists@example.com | hunter2  |
    When I register a new user with 
      | email              | password |
      | exists@example.com | hunter2  |
    Then I am made aware that the user is already registered
