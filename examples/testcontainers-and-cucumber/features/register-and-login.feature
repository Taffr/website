Feature: Register and Login
  As a new user
  I want to register and login
  So that I can maintain a session

  Scenario: Register a new user
    Given I register with email "test@example.com" and password "hunter2"
    Then I should receive a 201 response

  Scenario: Login with registered user
    When I login with email "test@example.com" and password "hunter2"
    Then I should receive a 404 response
