Feature: Contact Center - Get Customer List

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @getCustomerListStatus401
  Scenario Outline: Get Customer List - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/customers"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerListStatus400
  Scenario: Get Customer List - No Search Parameters
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65006" for key "errors[0].code"
    And response body should contain value of "No Search Parameter Provided" for key "errors[0].description"


  @getCustomerListStatus400
  Scenario Outline: Get Customer List - Email Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
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
  Scenario Outline: Get Customer List - sortBy Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
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
  Scenario Outline: Get Customer List - phoneNumber Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
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
  Scenario: Get Customer List - Space Character for phoneNumber
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "phoneNumber" with value "  "
    When I GET request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "phoneNumber" for key "errors[0].field"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"



  @getCustomerListStatus400
  Scenario Outline: Get Customer List - fullName Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
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
  Scenario Outline: Get Customer List - accountNumber Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
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
  Scenario: Get Customer List - No Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "fullName" with value "ASD"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of 0 for key "totalPages"


  # Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario: Get Customer List - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "email" with value "onb_happy_path_1@hymnai.com"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "totalPages": 1,
      "contents": [
        {
          "email": "onb_happy_path_1@hymnai.com",
          "fullName": "Ebru Soysal",
          "accountNumber": "10001530",
          "phoneNumber": "449999999999",
          "onboardingStatus": "REGISTRATION_COMPLETE",
          "key": "87889fe8-b1d2-4685-aaa6-d67f9c3a6697",
          "customerStatus": "ACTIVE"
        }
      ]
    }
    """



# Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario: Get Customer List - fullName Like Search
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "fullName" with value "unique"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "totalPages": 1,
      "contents": [
        {
          "email": "onb_name_DoB@hymnai.com",
          "fullName": "Unique Customer",
          "accountNumber": "",
          "onboardingStatus": "NAME_DOB_CAPTURED",
          "key": "fdc66c53-23c6-4804-9a9e-e85db5ddc679",
          "customerStatus": "PROSPECT"
        }
      ]
    }
    """


  # Agent logs in. Call this API with the access token
  @getCustomerList
  Scenario: Get Customer List - fullName Search
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "fullName" with value "Ebru1 Soysal"
    When I GET request to "/v1/customers"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "totalPages": 1,
      "contents": [
        {
          "email": "soysalsoysal@hymnai.com",
          "fullName": "Ebru1 Soysal",
          "accountNumber": "10001867",
          "phoneNumber": "441231231231",
          "onboardingStatus": "REGISTRATION_COMPLETE",
          "key": "377c7431-3a43-45d6-a99d-6e77dc2093e9",
          "customerStatus": "ACTIVE"
        }
      ]
    }
    """

