Feature: Customer Onboarding - Capture Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"
    And I set request header content type as JSON


  @putPhoneNumberHappyPath
  Scenario: Put Phone Number - Happy Path
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | phone | 441234567890 |

    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
    "phone": "441234567890",
    "status": "TELEPHONE_CAPTURED"
   }
  """


  @putPhoneNumberStatus400
  Scenario Outline: Put Phone Number - Invalid Phone Number
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | phone | <phoneValue> |
    When I PUT request to "/v1/customers/{email}/phone"
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


  @putPhoneNumberStatus409
  Scenario: Put Phone Number - Phone Number Already Exists
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 409
    And response body should contain value of "65010" for key "code"
    And response body should contain value of "Phone already exists" for key "message"


  @putPhoneNumberStatus400
  Scenario Outline: Put Phone Number - Token Validation Test
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "<tokenValue>"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "token" for key "validationErrors[0].field"
    And response body should contain value of "length must be 128" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                                                                                                        |
      |                                                                                                                                   |
      | asd                                                                                                                               |
      | asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsfs |


  @putPhoneNumberStatus400
  Scenario Outline: Put Phone Number - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @putPhoneNumberStatus500
  Scenario: Put Phone Number - Empty Email Validation Test
    And I set path parameter "email" with value ""
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 500


  @putPhoneNumberStatus404
  Scenario: Put Phone Number - No Customer Found
    And I set path parameter "email" with value "nocustomer@hymnai.com"
    And I set query parameter "token" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 404
    And response body should contain value of "65001" for key "code"
    And response body should contain value of "Customer not found with nocustomer@hymnai.com" for key "message"


  @putPhoneNumberStatus401
  Scenario: Put Phone Number - Email and Token not match
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "kmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"

