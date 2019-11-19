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
      | userName  | password       |
      | username1 | Password12341! |
      | username2 | Password12342! |
      | username3 | Password12343! |
      | username4 | Password12344! |
      | username5 | Password12345! |
      | username6 | Password12346! |

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
    ###### Password must be between 8-50
    ###### Password rules has to be set
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
      ###### Error message should be something different than "Fatal Error"
      ###### Can we handle this with a status code other than 500?
    Scenario Outline: Create CC Agent - Existing Username
      And I set request body with information given in the following table
        | username | <userName> |
        | password | <password> |
      When I POST request to "/v1/agents"
      Then response status code should be 500

      Examples:
        | userName  | password       |
        | username1 | Password12341! |
        | username2 | Password12342! |

      ######
      ### No example for 201:Created, 401:Unauthorized, 403:Forbidden, 404:Not Found
      ######