Feature: Customer Service - Refactor Get Customer List

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - Status Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "status" with value "<statusValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65046" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | statusValue      |  message                      |
      | ACT              |  Customer status is not valid |
      | 1234567890234    | Customer status is not valid  |
      | 111111111111     |  Customer status is not valid |
      | asdfg            |  Customer status is not valid |


  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - Status Validation - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "status" with value "<statusValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 200

    Examples:
      | statusValue |
      | ACTIVE      |
      | SUSPEND     |
      | DELETED     |
      | PROSPECT    |
      | FRAUD       |


  @getCustomerListNoDataFound
  Scenario:Refactor Get Customer List - No Data Found with invalid customer Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "customerKey" with value "45e03c6d7d-8e75-4441-b998-279da48ba69d"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of 0 for key "totalPages"


  @getCustomerListStatus401
  Scenario Outline: Refactor Get Customer List - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerListStatus400
  Scenario: Refactor Get Customer List - No Search Parameters
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65006" for key "errors[0].code"
    And response body should contain value of "No Search Parameter Provided" for key "errors[0].description"


  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - Email Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "email" with value "<emailValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<field>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | emailValue                                          | field | message                             |
      | asdsad                                              | email | must be a well-formed email address |
      | a@b.c                                               | email | size must be between 6 and 50       |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2op@asd.com | email | size must be between 6 and 50       |


  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - sortBy Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "sortBy" with value "<sortByValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<field>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | sortByValue                                         | field  | message                       |
      |                                                     | sortBy | size must be between 1 and 50 |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2opssdfsdfs | sortBy | size must be between 1 and 50 |


  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - phoneNumber Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "phoneNumber" with value "<phoneNumberValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<field>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | phoneNumberValue | field       | message              |
      | 12345            | phoneNumber | Invalid phone number |
      | 1234567890234    | phoneNumber | Invalid phone number |
      | 111111111111     | phoneNumber | Invalid phone number |
      | asdfg            | phoneNumber | Invalid phone number |



  @getCustomerListStatus400
  Scenario: Refactor Get Customer List - Space Character for phoneNumber
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "phoneNumber" with value "  "
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "phoneNumber" for key "errors[0].field"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"



  @getCustomerListStatus400
  Scenario Outline: Refactor Get Customer List - fullName Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "fullName" with value "<fullNameValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<field>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | fullNameValue                                       | field    | message                       |
      |                                                     | fullName | size must be between 2 and 50 |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2opssdfsdfs | fullName | size must be between 2 and 50 |


  @getCustomerListStatus400
  Scenario Outline:Refactor Get Customer List - accountNumber Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "accountNumber" with value "<accountNumberValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<field>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | accountNumberValue                                  | field         | message                       |
      |                                                     | accountNumber | size must be between 1 and 50 |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2opssdfsdfs | accountNumber | size must be between 1 and 50 |


  @getCustomerListNoDataFound
  Scenario:Refactor Get Customer List - No Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "fullName" with value "FTS"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of 0 for key "totalPages"

  # Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario: Get Customer List - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "email" with value "593_customerManager_917@yopmail.com"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "totalCount": 1,
  "contents": [
    {
      "email": "593_customerManager_917@yopmail.com",
      "fullName": "Laurine Wisoky",
      "accountNumber": "",
      "phoneNumber": "440780529841",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "key": "e03c6d7d-8e75-4441-b998-279da48ba69d",
      "customerStatus": "ACTIVE"
    }
  ]
}
    """

# Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario:Refactor Get Customer List - fullName Like Search
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "fullName" with value "Laurine"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "totalCount": 1,
  "contents": [
    {
      "email": "593_customerManager_917@yopmail.com",
      "fullName": "Laurine Wisoky",
      "accountNumber": "",
      "phoneNumber": "440780529841",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "key": "e03c6d7d-8e75-4441-b998-279da48ba69d",
      "customerStatus": "ACTIVE"
    }
  ]
}
    """


  # Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario:Refactor Get Customer List - fullName Search
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOGFjYjY4OC0xOTdkLTQzNDQtYWU2MS02OTE4MWI4OTQ2NDEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDIwNjI5NjAsImV4cCI6MTYwMjY2Nzc2MH0.8Daa-RuN8-t-gwHZpZOXpl7AAUrBnY3C8r6e9ufTaWwM7gauW3jw3RAyy2X56oz-2Rd9ZKfyTZkz4w2Mfd4Egg"
    And I set query parameter "fullName" with value "Seyma Yilmaz"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "totalCount": 1,
  "contents": [
    {
      "email": "cmtest11@yopmail.com",
      "fullName": "Seyma Yilmaz",
      "accountNumber": "",
      "phoneNumber": "440908464688",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "key": "b0c5a6ef-7649-4ad6-9a7e-e1b41f398d8e",
      "customerStatus": "ACTIVE"
    }
  ]
}
    """




