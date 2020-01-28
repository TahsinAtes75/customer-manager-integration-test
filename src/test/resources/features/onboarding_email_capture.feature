Feature: Customer Onboarding - Capture Customer Email

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"

  @captureEmailStatus400
  Scenario Outline: Capture Email - Email Validation Test
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | <email>  |
      | make     | Apple    |
      | model    | iPhone7+ |
      | serialNo | ASD1234  |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | email                                               | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      |                                                     | email     | size must be between 6 and 50       |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @captureEmailStatus400
  Scenario Outline: Capture Email - Make Validation Test
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | <make>      |
      | model    | iPhone7+    |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | make                                                | fieldName | message                       |
      |                                                     | make      | size must be between 1 and 50 |
      | sdasdad adad adadaa adadad sdfsdfsfsf sfsfsfsf 12+- | make      | size must be between 1 and 50 |


  @captureEmailStatus400
  Scenario Outline: Capture Email - Model Validation Test
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | <model>     |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | model                                               | fieldName | message                       |
      |                                                     | model     | size must be between 1 and 50 |
      | sfsdfsfsd sfsdfsfsd sfsdfsfsd sfsdfsfsd 123456+-!zx | model     | size must be between 1 and 50 |


  @captureEmailStatus400
  Scenario Outline: Capture Email - Serial Number Validation Test
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | iPhone7+    |
      | serialNo | <serialNo>  |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | serialNo                                            | fieldName | message                       |
      |                                                     | serialNo  | size must be between 1 and 50 |
      | sdssfsdf1233476487564783-56234563456-76573657836826 | serialNo  | size must be between 1 and 50 |

