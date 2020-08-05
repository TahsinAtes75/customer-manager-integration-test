Feature: Customer Onboarding - Refactor Create Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Email Validation Test

    And I set request body with information given in the following table
      | email    | <email>  |
      | make     | Apple    |
      | model    | iPhone7+ |
      | password | Pwd2021? |
      | serialNo | ASD1234  |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | email                                               | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | abcdhk.com                                          | email     | must be a well-formed email address |
      |                                                     | email     | size must be between 6 and 50       |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Make Validation Test
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | <make>      |
      | model    | iPhone7+    |
      | password | Pwd2021?    |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | make                                                | fieldName | message                       |
      |                                                     | make      | size must be between 1 and 50 |
      | sdasdad adad adadaa adadad sdfsdfsfsf sfsfsfsf 12+- | make      | size must be between 1 and 50 |


  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Model Validation Test
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | <model>     |
      | password | Pwd2021?    |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | model                                               | fieldName | message                       |
      |                                                     | model     | size must be between 1 and 50 |
      | sfsdfsfsd sfsdfsfsd sfsdfsfsd sfsdfsfsd 123456+-!zx | model     | size must be between 1 and 50 |


  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Serial Number Validation Test
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | iPhone7+    |
      | password | Pwd2021?    |
      | serialNo | <serialNo>  |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | serialNo                                            | fieldName | message                       |
      |                                                     | serialNo  | size must be between 1 and 50 |
      | sdssfsdf1233476487564783-56234563456-76573657836826 | serialNo  | size must be between 1 and 50 |


  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Password Validation Test-1
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | iPhone7+    |
      | password | <password>  |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldValue>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"


    Examples:
      | password                                            | fieldValue | message                                                    |
      |                                                     | password   | size must be between 8 and 50     |
      | Pa2?                                                | password   | size must be between 8 and 50     |
      | pass                                                | password   | size must be between 8 and 50     |
      | Pwd49testPwd49testPwd49testPwd49testPwd49testPwd49? | password   | size must be between 8 and 50     |
      | Pwd49testPwd49testPwd49testPwd49testPwd49testPwd49t | password   | size must be between 8 and 50     |


  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Password Validation Test-2
    And I set request body with information given in the following table
      | email    | asd@asd.com |
      | make     | Apple       |
      | model    | iPhone7+    |
      | password | <password>  |
      | serialNo | ASD1234     |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "67000" for key "errors[0].code"
    And response body should contain value of "<fieldValue>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"


    Examples:
      | password                                            | fieldValue | message                                                    |
      | Password123!                                        | password   | Password contains the illegal numerical sequence '123'.    |
      | Password555!                                        | password   | Password matches the illegal pattern '555'.                |
      | Password_asdfg2                                     | password   | Password contains the illegal QWERTY sequence 'asd'.       |
      | Pass82aaa?                                          | password   | Password matches the illegal pattern 'aaa'.                |
      | Pass82xyz?                                          | password   | Password contains the illegal alphabetical sequence 'xyz'. |
      | password                                            | password   | Password must contain 1 or more uppercase characters.      |
      | Password                                            | password   | Password must contain 1 or more digit characters.          |
      | Password5                                           | password   | Password must contain 1 or more special characters.        |
      | Password?                                           | password   | Password must contain 1 or more digit characters.          |
      | 20192020                                            | password   | Password must contain 1 or more lowercase characters.      |

  @createCustomerStatus400
  Scenario Outline: Refactor Create Customer - Duplication Test

    And I set request body with information given in the following table
      | email    | <email>  |
      | make     | Apple    |
      | model    | iPhone7+ |
      | password | Pwd2021? |
      | serialNo | ASD1234  |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65016" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | email                                               |  message                             |
      |  brucelee@yopmail.com                               | There is another customer recorded with the same email. Please call Contact Centre for further questions. |
      |  newonbr@yopmail.com                                | There is another customer recorded with the same email. Please call Contact Centre for further questions. |
      |  alexandra.constantin@yahoo.com                     | There is another customer recorded with the same email. Please call Contact Centre for further questions.       |

   #if there is recorded email it gives an error message

  @createCustomerStatus400
  Scenario: Refactor Create Customer - Happy Path

    And I set request body with information given in the following table
      | email    | newonboarding3@yopmail.com |
      | make     | Apple                     |
      | model    | iPhone7+                  |
      | password | Pwd2021?                  |
      | serialNo | ASD1234                   |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200




