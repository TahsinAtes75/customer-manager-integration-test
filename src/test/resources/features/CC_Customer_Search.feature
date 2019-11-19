Feature: Contact Center - Customer Search

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"

  @searchCustomerStatus400
  Scenario: Search Customer - No Search Parameters
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65004" for key "code"
    And response body should contain value of "No Search Parameter Provided" for key "message"

  @searchCustomerStatus400
  Scenario Outline: Search Customer - Email Validation
    And I set query parameter "email" with value "<emailValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<field>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | field | message                             |
      | asdsad                                              | email | must be a well-formed email address |
      | a@b.c                                               | email | size must be between 6 and 50       |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2op@asd.com | email | size must be between 6 and 50       |

  @searchCustomerStatus200
  Scenario: Search Customer - No Data Found
    And I set query parameter "fullName" with value "ASD"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of 0 for key "totalPages"


  @searchCustomerStatus200
  Scenario: Search Customer - Data Found
    And I set query parameter "email" with value "sample3@trial.com"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "totalPages": 1,
      "contents": [
        {
          "email": "sample3@trial.com",
          "fullName": "Name Name Surname Surname",
          "accountNumber": "12345678",
          "phoneNumber": "1234567890",
          "status": "NAME_DOB_CAPTURED",
          "number": 70127954
        }
      ]
    }
    """

  @searchCustomerByNumberStatus200
  Scenario: Search Customer - Search by Number Happy Path
    And I set path parameter "number" with value "92145124"
    When I GET request to "/v1/customers/{number}"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "${json-unit.ignore}",
    "fullName": "${json-unit.ignore}",
    "accountNumber": "${json-unit.ignore}",
    "phoneNumber": "${json-unit.ignore}",
    "status": "${json-unit.ignore}",
    "number": 92145124
  }
  """

  @searchCustomerByNumberStatus404
  Scenario: Search Customer - Search by Number Not Found
    And I set path parameter "number" with value "123"
    When I GET request to "/v1/customers/{number}"
    Then response status code should be 404
    And response body should contain value of "65005" for key "code"
    And response body should contain value of "Customer not found with number" for key "message"


  @searchCustomerByNumberStatus400
  Scenario: Search Customer - Search by Empty Number
    And I set path parameter "number" with value ""
    When I GET request to "/v1/customers/{number}"
    Then response status code should be 400