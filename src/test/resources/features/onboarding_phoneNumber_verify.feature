Feature: Customer Onboarding - Verify Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - Invalid SMS Code
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "code" for key "validationErrors[0].field"
    And response body should contain value of "length must be 6" for key "validationErrors[0].message"

    Examples:
      | smsValue |
      |          |
      | 123      |
      | 1234567  |


  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - SMS Code Not Verified
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "phone" with value "445554443332"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"

    Examples:
      | smsValue |
      | qwerty   |
      | 111111   |


    ### Manually get the expired SMS Code from DB
    ### Email-phone-code are a match but SMS code is expired
  @verifyPhoneNumberStatus401
  Scenario: Verify Phone Number - SMS Code Expired
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "725885"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65012" for key "code"
    And response body should contain value of "SMS code expired" for key "message"


  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - Email, Phone, SmsCode do not match
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "<codeValue>"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"

    Examples:
      | emailValue          | phoneValue   | codeValue |
      | notexist@hymnai.com | 441234567890 | 123456    |
      | e.soysal@hymnai.com | 445556667778 | 565287    |



  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "565287"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - Phone Number Validation Test
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "565287"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "phone" for key "validationErrors[0].field"
    And response body should contain value of "Invalid phone number" for key "validationErrors[0].message"

    Examples:
      | phoneValue    |
      |               |
      | 441           |
      | 4412345678900 |
      | 123456789012  |
      | 44qwertyuiop  |
      | qwertyuriopp  |
