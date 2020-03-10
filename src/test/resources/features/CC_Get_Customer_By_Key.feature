Feature: Contact Center - Get Customer By Key

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerByKey
  Scenario: Get Customer By Key - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "3d570139-c34f-4198-a7eb-e003babcc192"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
  """
    {
      "customerKey": "3d570139-c34f-4198-a7eb-e003babcc192",
      "customerEmail": "onb_happy_path_3@hymnai.com",
      "emailVerified": true,
      "phoneNumber": "449191919193",
      "phoneVerified": true,
      "givenNames": "Ebru",
      "surname": "Soysal",
      "fullName": "Ebru Soysal",
      "dateOfBirth": "1982-01-01",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "customerStatus": "ACTIVE",
      "address": {
        "line1": "3 Queen's Road",
        "line2": "",
        "town": "Reading",
        "county": "Berkshire",
        "country": "UK",
        "postcode": "RG1 4AP",
        "verified": false
      }
    }
  """


  @getCustomerByKey
  Scenario: Get Customer By Key - Prospect Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "8a307f49-7a77-47d2-9644-e941dd666428"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "customerKey": "8a307f49-7a77-47d2-9644-e941dd666428",
      "customerEmail": "onb_name_DoB@hymnai.com",
      "emailVerified": true,
      "phoneVerified": false,
      "givenNames": "string",
      "surname": "string",
      "fullName": "string string",
      "dateOfBirth": "1980-01-01",
      "onboardingStatus": "NAME_DOB_CAPTURED",
      "customerStatus": "PROSPECT"
    }
    """


  @getCustomerByKey
  Scenario: Get Customer By Key - Deleted Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "4ce270ac-7018-496c-b0aa-75f76d8036a1"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "customerKey": "4ce270ac-7018-496c-b0aa-75f76d8036a1",
      "customerEmail": "deleted_customer@hymnai.com",
      "emailVerified": false,
      "phoneVerified": false,
      "onboardingStatus": "EMAIL_CAPTURED",
      "customerStatus": "DELETED"
    }
    """

  @getCustomerByKey
  Scenario: Get Customer By Key - Suspend Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "a2ade24b-eafe-4c1b-b64a-28b906b877b1"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "customerKey": "a2ade24b-eafe-4c1b-b64a-28b906b877b1",
      "customerEmail": "suspend_customer@hymnai.com",
      "emailVerified": false,
      "phoneVerified": false,
      "onboardingStatus": "EMAIL_CAPTURED",
      "customerStatus": "SUSPEND"
    }
    """


  @getCustomerByKey
  Scenario: Get Customer By Key - Fraud Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "dd750b32-e1f2-48e5-89c7-35bfbfad4c55"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "customerKey": "dd750b32-e1f2-48e5-89c7-35bfbfad4c55",
      "customerEmail": "fraud_customer@hymnai.com",
      "emailVerified": false,
      "phoneVerified": false,
      "onboardingStatus": "EMAIL_CAPTURED",
      "customerStatus": "FRAUD"
    }
    """


  @getCustomerByKeyStatus401
  Scenario Outline: Get Customer By Key - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |


  @getCustomerByKeyStatus400
  Scenario Outline: Get Customer By Key - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |



  @getCustomerByKeyStatus404
  Scenario Outline: Get Customer By Key - Search by Key - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |

