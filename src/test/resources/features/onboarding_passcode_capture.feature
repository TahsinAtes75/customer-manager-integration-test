Feature: Customer Onboarding - Capture Customer Passcode

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @capturePasscodeStatus400
  Scenario Outline: Customer Passcode - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @capturePasscodeStatus500
  Scenario: Customer Passcode - Empty Email
    And I set path parameter "email" with value ""
    And I set query parameter "onboardingToken" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 500


  @capturePasscodeStatus400
  Scenario Outline: Customer Passcode - Token Validation Test
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "onboardingToken" with value "<tokenValue>"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "onboardingToken" for key "validationErrors[0].field"
    And response body should contain value of "length must be 128" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                                                                                                        |
      |                                                                                                                                   |
      | asd                                                                                                                               |
      | asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsfs |


  @capturePasscodeStatus400
  Scenario Outline: Customer Passcode - Passcode Validation Test
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "onboardingToken" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | passcode | <passcodeValue> |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "passcode" for key "validationErrors[0].field"
    And response body should contain value of "only digit and length must be 6" for key "validationErrors[0].message"

    Examples:
      | passcodeValue |
      |               |
      | 12345         |
      | 1234567       |
      | 123asd        |
      | qwerty        |
      | 12345@        |


  @capturePasscodeStatus404
  Scenario: Customer Passcode - No Customer Found
    And I set path parameter "email" with value "nocustomer@hymnai.com"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 404
    And response body should contain value of "65001" for key "code"
    And response body should contain value of "Customer not found with nocustomer@hymnai.com" for key "message"


  @capturePasscodeStatus401
  Scenario: Customer Passcode - Email and Token not match
    And I set path parameter "email" with value "Sprint3test@hymnai.com"
    And I set query parameter "onboardingToken" with value "kmzuhpmgcfliekvpw1khhl0aewig8y8pwng3hgxhailwbrzpfa3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"
