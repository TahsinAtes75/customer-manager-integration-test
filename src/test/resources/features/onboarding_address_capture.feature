Feature: Customer Onboarding - Capture Customer Address

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @captureAddressStatus400
  Scenario Outline: Capture Address - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @captureAddressStatus500
  Scenario: Capture Address - Empty Email Test
    And I set path parameter "email" with value ""
    And I set query parameter "onboardingToken" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 500


  @captureAddressStatus400
  Scenario Outline: Capture Address - Token Validation Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "onboardingToken" with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                                                                                                        | fieldName       | message            |
      |                                                                                                                                   | onboardingToken | length must be 128 |
      | asd                                                                                                                               | onboardingToken | length must be 128 |
      | asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsfs | onboardingToken | length must be 128 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Country Validation Test
    And I set path parameter "email" with value "adsd@xddsd.com"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | country  | <countryValue>    |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | countryValue                                        | fieldName | message                       |
      |                                                     | country   | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | country   | size must be between 1 and 50 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Line1 Validation Test
    And I set path parameter "email" with value "adsd@xddsd.com"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | country  | UK           |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line1Value                                          | fieldName | message                       |
      |                                                     | line1     | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | line1     | size must be between 1 and 50 |



  @captureAddressStatus400
  Scenario Outline: Capture Address - PostCode Validation Test
    And I set path parameter "email" with value "adsd@xddsd.com"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | <postCodeValue>   |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | postCodeValue                                       | fieldName | message                       |
      |                                                     | postCode  | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | postCode  | size must be between 1 and 50 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Town Validation Test
    And I set path parameter "email" with value "adsd@xddsd.com"
    And I set query parameter "onboardingToken" with value "tmzuhpmgcfliekvpw1khhl0mewig8y8pwng3hgxhailwbrzpfx3c8zamcj2c0wopb9tc4mz5mx0vuxeki94cjefroswgtufd5gmxojoxhaxlwkfeq0pgucjbmagt8acz"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | RG1 7EB           |
      | town     | <townValue>       |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | townValue                                           | fieldName | message                       |
      |                                                     | town      | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | town      | size must be between 1 and 50 |
