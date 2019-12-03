Feature: Contact Center - Customer Search

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"


  ########################################
  ####### GET Customer ###################
  ########################################
  @searchCustomerStatus400
  Scenario: Search Customer - No Search Parameters
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65006" for key "code"
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
    And I set query parameter "email" with value "test3@hymnai.com"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "totalPages": 1,
      "contents": [
        {
          "email": "test3@hymnai.com",
          "fullName": "${json-unit.ignore}",
          "accountNumber": "${json-unit.ignore}",
          "phoneNumber": "${json-unit.ignore}",
          "status": "${json-unit.ignore}",
          "number": "${json-unit.ignore}",
          "key": "${json-unit.ignore}"
        }
      ]
    }
    """

    ############################################
    ###### Search Customer by Number ###########
    ############################################
  @searchCustomerByNumberStatus200
  Scenario: Search Customer - Search by Number Happy Path
    And I set path parameter "number" with value "53426117"
    When I GET request to "/v1/customers/number/{number}"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "${json-unit.ignore}",
    "fullName": "${json-unit.ignore}",
    "accountNumber": "${json-unit.ignore}",
    "phoneNumber": "${json-unit.ignore}",
    "status": "${json-unit.ignore}",
    "number": 53426117,
    "key": "${json-unit.ignore}"
  }
  """

  @searchCustomerByNumberStatus404
  Scenario: Search Customer - Search by Number Not Found
    And I set path parameter "number" with value "123"
    When I GET request to "/v1/customers/number/{number}"
    Then response status code should be 404
    And response body should contain value of "65007" for key "code"
    And response body should contain value of "Customer not found with number" for key "message"


  @searchCustomerByNumberStatus400
  Scenario: Search Customer - Search by Empty Number
    And I set path parameter "number" with value ""
    When I GET request to "/v1/customers/number/{number}"
    Then response status code should be 400

  ########################################
  ###### Search Customer by Key ##########
  ########################################

  ###
  # An Account number is added manually for the specified customer
  ###
  @searchCustomerByKeyStatus200
  Scenario: Search Customer - Search by Key Happy Path
    And I set path parameter "key" with value "f00c2df3-a836-4ed0-898e-cb90f55fdcd6"
    When I GET request to "/v1/customers/{key}"
    Then response status code should be 200
    And response body should contain the key "accountNumber" with a not-null value
    And response body should be following json
  """
  {
    "email": "test3@hymnai.com",
    "fullName": "${json-unit.ignore}",
    "accountNumber": "${json-unit.ignore}",
    "phoneNumber": "${json-unit.ignore}",
    "status": "${json-unit.ignore}",
    "number": "${json-unit.ignore}",
    "key": "f00c2df3-a836-4ed0-898e-cb90f55fdcd6"
  }
  """

  @searchCustomerByKeyStatus400
  Scenario Outline: Search Customer - Search by Key - Invalid Key
    And I set path parameter "key" with value "<keyValue>"
    When I GET request to "/v1/customers/{key}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "key" for key "validationErrors[0].field"
    And response body should contain value of "length must be 36" for key "validationErrors[0].message"

    Examples:
      | keyValue                              |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |

  @searchCustomerByKeyStatus400
  Scenario: Search Customer - Search by Key - Empty Key
    And I set path parameter "key" with value ""
    When I GET request to "/v1/customers/{key}"
    Then response status code should be 400
    And response body should contain value of "65006" for key "code"
    And response body should contain value of "No Search Parameter Provided" for key "message"


  @searchCustomerByKeyStatus404
  Scenario Outline: Search Customer - Search by Key - Customer Not Found
    And I set path parameter "key" with value "<keyValue>"
    When I GET request to "/v1/customers/{key}"
    Then response status code should be 404
    And response body should contain value of "65011" for key "code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "message"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |



