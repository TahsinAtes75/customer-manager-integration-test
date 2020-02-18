Feature: Contact Center - Get Customer By Key

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @getCustomerByKey
  Scenario: Get Customer By Key - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "87889fe8-b1d2-4685-aaa6-d67f9c3a6697"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
  """
    {
      "key": "87889fe8-b1d2-4685-aaa6-d67f9c3a6697",
      "email": "onb_happy_path_1@hymnai.com",
      "emailVerified": true,
      "phoneNumber": "449999999999",
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
        "county": "Berkshire 123",
        "country": "UK",
        "postCode": "RG1 4AP",
        "verified": false
      }
    }
  """


  @getCustomerByKey
  Scenario: Get Customer By Key - Prospect Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "fdc66c53-23c6-4804-9a9e-e85db5ddc679"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "key": "fdc66c53-23c6-4804-9a9e-e85db5ddc679",
      "email": "onb_name_DoB@hymnai.com",
      "emailVerified": true,
      "phoneVerified": false,
      "givenNames": "Unique",
      "surname": "Customer",
      "fullName": "Unique Customer",
      "dateOfBirth": "1980-01-01",
      "onboardingStatus": "NAME_DOB_CAPTURED",
      "customerStatus": "PROSPECT"
    }
    """


  @getCustomerByKey
  Scenario: Get Customer By Key - Deleted Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "de04486a-b1bb-4722-8ee6-a0ec8405df93"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "key": "de04486a-b1bb-4722-8ee6-a0ec8405df93",
      "email": "deleted_customer@hymnai.com",
      "emailVerified": false,
      "phoneVerified": false,
      "onboardingStatus": "EMAIL_CAPTURED",
      "customerStatus": "DELETED"
    }
    """

  @getCustomerByKey
  Scenario: Get Customer By Key - Suspend Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "f0ef9a95-7dd9-4aef-864f-6e60e55f476c"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "key": "f0ef9a95-7dd9-4aef-864f-6e60e55f476c",
      "email": "suspend_customer@hymnai.com",
      "emailVerified": false,
      "phoneVerified": false,
      "onboardingStatus": "EMAIL_CAPTURED",
      "customerStatus": "SUSPEND"
    }
    """


  @getCustomerByKey
  Scenario: Get Customer By Key - Fraud Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "c5671a1f-8ecd-45de-92bc-72f1f8a47cd5"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "key": "c5671a1f-8ecd-45de-92bc-72f1f8a47cd5",
      "email": "fraud_customer@hymnai.com",
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
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

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
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "key" for key "validationErrors[0].field"
    And response body should contain value of "length must be 36" for key "validationErrors[0].message"

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
    And response body should contain value of "65011" for key "code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "message"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |

