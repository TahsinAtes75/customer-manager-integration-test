Feature: Customer Onboarding - Capture Customer Name and Date of Birth

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"
    And I set request header content type as JSON

           ##
    # Manually get the onboarding token from DB
    ##
  @putNameAndDoBHappyPath
  Scenario: Put Name and DoB - Happy Path
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "5fw4e2i9yavy1dkgq1yslfhhgly6nq0yxq6iec1vetjravq5g0dwchjhk6k8b4jttwyrlpdrdn0dd9x67ylgnqkgf4k2ptuxjhyvrja5tczikbd4jrwigcqkinx9rcdc"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
    "givenNames": "Ebru",
    "surname": "Soysal",
    "dateOfBirth": "1982-01-01",
    "status": "NAME_DOB_CAPTURED"
   }
  """

  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "token" with value "e1alfzfju87hzvjvb0svigjgg7ijslt2vbab6yzxs1nxrghzs06dke93hdxwssvgqp9yrqves4yitww5iz6mhavfp9fwnjmticuvdsctjao14brvhhb9z3urdpdvfslu"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | 1980-01-01      |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @@putNameAndDoBStatus500
  Scenario: Put Name and DoB - Empty Email Validation Test
    And I set path parameter "email" with value ""
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 500


  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Token Validation Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "token" with value "<tokenValue>"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | 1980-11-15      |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                                                                                                        | fieldName | message            |
      |                                                                                                                                   | token     | length must be 128 |
      | asd                                                                                                                               | token     | length must be 128 |
      | asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsfs | token     | length must be 128 |

  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Given Names Validation Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | givenNames  | <givenNamesValue> |
      | surname     | Surname Surname   |
      | dateOfBirth | 1980-11-15        |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | givenNamesValue                                     | fieldName  | message                       |
      |                                                     | givenNames | size must be between 1 and 50 |
      | as123asdsdwewe123as d123assdasd123 asd1asdsdfsfsfsr | givenNames | size must be between 1 and 50 |


  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Surname Validation Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | givenNames  | Name Name      |
      | surname     | <surnameValue> |
      | dateOfBirth | 1980-11-15     |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | surnameValue                                        | fieldName | message                       |
      |                                                     | surname   | size must be between 1 and 50 |
      | as123asdsdwewe123as d123assdasd123 asd1asdsdfsfsfsr | surname   | size must be between 1 and 50 |


  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Date of Birth Validation Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | <DoBValue>      |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65004" for key "code"
    And response body should contain value of "Http Message Not Readable" for key "message"

    Examples:
      | DoBValue    |
      | asdf        |
      | 1980        |
      | 1980-11     |
      | 1980-13-01  |
      | 1980-112-01 |
      | 1980-1-01   |
      | 1980-12-32  |
      | 1983-01-123 |
      | 1983-01-1   |
      | 1983-02-29  |
      | 1983-04-31  |


  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Date of Birth Rules Test
    And I set path parameter "email" with value "asdf@fgh.com"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | <DoBValue>      |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | DoBValue   | fieldName   | message                              |
      |            | dateOfBirth | Date can not be empty                |
      | 1899-11-15 | dateOfBirth | Age must be 120 years old or younger |
      | 2030-01-01 | dateOfBirth | Date can not be a future date        |
      | 2010-01-01 | dateOfBirth | Age must be 18 years old or older    |


  @putNameAndDoBStatus401
  Scenario: Put Name and DoB - Email and Token not match
    And I set path parameter "email" with value "sample1@trial.com"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | 1980-11-15      |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"


