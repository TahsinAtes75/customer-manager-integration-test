Feature: Contact Center - Agent Login Unlock-Lock-Unlock

  Background:
    Given I set REST API url as "https://security-manager.dev.heymanai.com"
    And I set request header content type as JSON

  @unlockCcAgent
  Scenario: Unlock Agent
    And I set path parameter "username" with value "username4"
    When I PUT request to "/v1/agents/{username}/unlock"
    Then response status code should be 204

  @lockCcAgent
  Scenario Outline: Agent Login - More than 3 tries
    And I set request body with information given in the following table
      | username | <userName>    |
      | password | WrongPassword |
    When I POST request to "/v1/agents/login"
    Then response status code should be 401
    And response body should contain value of "<message>" for key "message"

    Examples:
      | userName  | message                |
      | username4 | Bad credentials        |
      | username4 | Bad credentials        |
      | username4 | Bad credentials        |
      | username4 | User account is locked |

  @unlockCcAgent
  Scenario: Unlock Agent
    And I set path parameter "username" with value "username4"
    When I PUT request to "/v1/agents/{username}/unlock"
    Then response status code should be 204


  @unlockAgentStatus404
  Scenario: Unlock Agent - Not Existing Agent
    And I set path parameter "username" with value "asdfgh"
    When I PUT request to "/v1/agents/{username}/unlock"
    Then response status code should be 404
    And response body should contain value of "67006" for key "code"
    And response body should contain value of "An agent with the specified username does not exist." for key "message"


  @unlockAgentStatus400
  Scenario Outline: Unlock Agent - username Validation
    And I set path parameter "username" with value "<userName>"
    When I PUT request to "/v1/agents/{username}/unlock"
    Then response status code should be 400
    And response body should contain value of "67000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | userName                                            | fieldName | message                       |
      | a                                                   | username  | size must be between 2 and 50 |
      | username3username3username3username3username3userna | username  | size must be between 2 and 50 |


  @unlockAgentStatus500
  Scenario: Unlock Agent - Empty username
    And I set path parameter "username" with value ""
    When I PUT request to "/v1/agents/{username}/unlock"
    Then response status code should be 500