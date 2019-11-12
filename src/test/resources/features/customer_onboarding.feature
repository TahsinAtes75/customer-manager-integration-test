Feature: Customer Onboarding

  Background:
    Given I set REST API url as "http://127.0.0.1:3100"
    #And I set request header content type as JSON


  @captureEmailHappyPathStatus200
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | ebru@trial.com |
      | make     | Apple          |
      | model    | iphone7        |
      | serialNo | 123456         |
    When I POST request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of "ebru@trial.com" for key "email"
    And response body should contain value of "Email Captured" for key "status"
    And response body should contain value not equal to 0 for key "number"


  @captureEmailHappyPathStatus400
  Scenario Outline: Capture Email - Input Validation Test
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | <email>    |
      | make     | <make>     |
      | model    | <model>    |
      | serialNo | <serialNo> |
    When I POST request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | email                                               | make                                                | model                                               | serialNo                                            | fieldName | message              |
      | sdfhghg                                             | Apple                                               | iphone7                                             | AB123                                               | email     | The field is invalid |
      |                                                     | Apple                                               | iphone7                                             | AB123                                               | email     | The field is invalid |
      | a@b.c                                               | Apple                                               | iphone7                                             | AB123                                               | email     | The field is invalid |
      | asasasasasasasasasasasasasasas@asasasasasasasas.com | Apple                                               | iphone7                                             | AB123                                               | email     | The field is invalid |
      | ebru@trial.com                                      |                                                     | iphone7                                             | AB123                                               | make      | The field is invalid |
      | ebru@trial.com                                      | A                                                   | iphone7                                             | AB123                                               | make      | The field is invalid |
      | ebru@trial.com                                      | Ahasd123gs/sdenfrhdrd Ahasd123gs Ahasd123gs Ahasd12 | iphone7                                             | AB123                                               | make      | The field is invalid |
      | ebru@trial.com                                      | Apple                                               |                                                     | AB123                                               | model     | The field is invalid |
      | ebru@trial.com                                      | Apple                                               | 1                                                   | AB123                                               | model     | The field is invalid |
      | ebru@trial.com                                      | Apple                                               | Abcde123456/+asdfghjk Abcde123456 Abcde123456 Abcdq | AB123                                               | model     | The field is invalid |
      | ebru@trial.com                                      | Apple                                               | iphone7+                                            |                                                     | serialNo  | The field is invalid |
      | ebru@trial.com                                      | Apple                                               | iphone7+                                            | A                                                   | serialNo  | The field is invalid |
      | ebru@trial.com                                      | Apple                                               | iphone7+                                            | Abcde12345u6/+wertyuk Abcde12345u6 Abcde12345u6 Abc | serialNo  | The field is invalid |


  @verifyEmailHappyPathStatus200
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "ebru@trial.com"
    And I set query parameter "token" with value "testToken"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain value of "ebru@trial.com" for key "email"
    And response body should contain value of "testOnboardingToken" for key "onboardingToken"
    And response body should contain value of "Email Verified" for key "status"


  @verifyEmailHappyPathStatus400
  Scenario Outline: Verify Email - Input Validation Test
    And I set path parameter "email" with value "asd@asd.com"
    And I set query parameter "token" with value "<tokenValue>"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                          | fieldName | message          |
      |                                                     | token     | Field is invalid |
      | asd                                                 | token     | Field is invalid |
      | asd123asd123asd123asd123asd123asd123asd123asd123asd | token     | Field is invalid |
