Feature: Contact Center - Agent Login

  Background:
    Given I set REST API url as "https://security-manager.dev.heymanai.com"
    And I set request header content type as JSON

  @loginCcAgentHappyPath
  Scenario Outline: Agent Login - Happy Path
    And I set request body with information given in the following table
      | username | <userName> |
      | password | <password> |
    When I POST request to "/v1/agents/login"
    Then response status code should be 200
    And response body should contain the key "accessToken" with a not-null value
    And response body should be following json
    """
    {
      "accessToken": "${json-unit.ignore}",
      "tokenType": "Bearer",
      "expired": false,
      "expiredAt": "${json-unit.ignore}"
    }
    """

    Examples:
      | userName  | password       |
      | username2 | Password12342! |
      | username3 | Password12343! |

  @loginCcAgentStatus401
  Scenario Outline: Agent Login - Wrong Password
    And I set request body with information given in the following table
      | username | <userName> |
      | password | <password> |
    When I POST request to "/v1/agents/login"
    Then response status code should be 401
    And response body should contain value of "401" for key "code"
    And response body should contain value of "Bad credentials" for key "message"

    Examples:
      | userName  | password    |
      | username1 | Password123 |
      | username2 | Password123 |


  @loginCcAgentStatus404
  Scenario: Agent Login - Not Existing Agent
    And I set request body with information given in the following table
      | username | asdasd |
      | password | asdasd |
    When I POST request to "/v1/agents/login"
    Then response status code should be 404
    And response body should contain value of "67006" for key "code"
    And response body should contain value of "An agent with the specified username does not exist." for key "message"


  @loginCcAgentStatus400
  Scenario Outline: Agent Login - Input Validation
    And I set request body with information given in the following table
      | username | <userName> |
      | password | <password> |
    When I POST request to "/v1/agents/login"
    Then response status code should be 400
    And response body should contain value of "67000" for key "code"
    And response body should contain value of "<field>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | userName                                            | password                                            | field    | message                       |
      |                                                     | Password123                                         | username | size must be between 2 and 50 |
      | a                                                   | Password123                                         | username | size must be between 2 and 50 |
      | qwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopp | Password123                                         | username | size must be between 2 and 50 |
      | username1                                           |                                                     | password | size must be between 4 and 50 |
      | username1                                           | 123                                                 | password | size must be between 4 and 50 |
      | username1                                           | Password123Password123Password123Password123Passwor | password | size must be between 4 and 50 |


  @lockCcAgen
  Scenario Outline: Agent Login - More than 3 tries
    And I set request body with information given in the following table
      | username | <userName>    |
      | password | WrongPassword |
    When I POST request to "/v1/agents/login"
    Then response status code should be 401
    And response body should contain value of "<message>" for key "message"

    Examples:
      | userName  | message                |
      | username1 | Bad credentials        |
      | username1 | Bad credentials        |
      | username1 | Bad credentials        |
      | username1 | User account is locked |


  @loginCcAgentStatus401
  Scenario: Agent Login - Account Lock
    And I set request body with information given in the following table
      | username | username5 |
      | password | asdasd    |
    When I POST request to "/v1/agents/login"
    Then response status code should be 401
    And response body should contain value of "401" for key "code"
    And response body should contain value of "User account is locked" for key "message"


  ##
  ##### Manually set expiry date
  ##
  @loginCcAgentStatus401
  Scenario: Agent Login - Password Expired
    And I set request body with information given in the following table
      | username | username6      |
      | password | Password12346! |
    When I POST request to "/v1/agents/login"
    Then response status code should be 401
    And response body should contain value of "401" for key "code"
    And response body should contain value of "User credentials have expired" for key "message"






