Feature: Contact Center - Create New Agent

  Background:
    Given I set REST API url as "https://security-manager.dev.heymanai.com"
    And I set request header content type as JSON

  @createCcAgentHappyPath
  Scenario Outline: Create CC Agent - Happy Path
    And I set request body with information given in the following table
      | username | <userName> |
      | password | <password> |
    When I POST request to "/v1/agents"
    Then response status code should be 200

    Examples:
      | userName   | password     |
      | username11 | Password123! |
      | username12 | Password123! |
      | username13 | Password123! |
      | username14 | Password123! |
      | username15 | Password123! |
      | username16 | Password123! |

  @createCcAgentStatus400
  Scenario Outline: Create CC Agent - Username Validation Test
    And I set request body with information given in the following table
      | username | <userName> |
      | password | 12345678   |
    When I POST request to "/v1/agents"
    Then response status code should be 400
    And response body should contain value of "67000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | userName                                            | fieldName | message                       |
      |                                                     | username  | size must be between 2 and 50 |
      | a                                                   | username  | size must be between 2 and 50 |
      | username3username3username3username3username3userna | username  | size must be between 2 and 50 |


  @createCcAgentStatus400
  Scenario Outline: Create CC Agent - Password Validation Test
    And I set request body with information given in the following table
      | username | asdfghjkl  |
      | password | <password> |
    When I POST request to "/v1/agents"
    Then response status code should be 400
    And response body should contain value of "67000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | password                                            | fieldName | message                       |
      |                                                     | password  | size must be between 4 and 50 |
      | 123                                                 | password  | size must be between 4 and 50 |
      | Password123433dPassword123433dPassword123433dPasswo | password  | size must be between 4 and 50 |

  @createCcAgentStatus500
  Scenario Outline: Create CC Agent - Existing Username
    And I set request body with information given in the following table
      | username | <userName> |
      | password | <password> |
    When I POST request to "/v1/agents"
    Then response status code should be 409
    And response body should contain value of "67003" for key "code"
    And response body should contain value of "Agent with the username <userName> already exist." for key "message"

    Examples:
      | userName  | password       |
      | username1 | Password12341! |
      | username2 | Password12342! |


