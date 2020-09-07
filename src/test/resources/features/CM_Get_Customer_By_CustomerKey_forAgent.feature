Feature: Customer Service - Get Customer By Customer Key for Agent

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "a05d7321-c58a-4cd2-a222-11af827fe75c"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
  """
    {
  "customerKey": "a05d7321-c58a-4cd2-a222-11af827fe75c",
  "customerEmail": "customerinfo9@yopmail.com",
  "emailVerified": true,
  "phoneNumber": "449088888883",
  "phoneVerified": true,
  "givenNames": "Ayse",
  "surname": "Aslan",
  "fullName": "Ayse Aslan",
  "preferredName": "Zeynep",
  "dateOfBirth": "1970-07-07",
  "onboardingStatus": "REGISTRATION_COMPLETE",
  "customerStatus": "ACTIVE",
  "idStatus": "clear",
  "photoStatus": "clear",
  "addressStatus": "clear",
  "watchlistStatus": "clear",
  "warnings": [],
  "address": {
    "addressKey": "98dd28ac-ff46-45b9-b433-dbebee7462c9",
    "line1": "Kingston road",
    "line2": "string",
    "town": "Kingston",
    "county": "",
    "country": "GBR",
    "postcode": "KT1 2EE",
    "verified": false
  }
 }
  """


  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Prospect Customer with warnings message
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "efabacfb-9bed-4aa4-84e5-72418def8b0f"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "customerKey": "efabacfb-9bed-4aa4-84e5-72418def8b0f",
  "customerEmail": "warningtest@yopmail.com",
  "emailVerified": true,
  "phoneNumber": "446666663783",
  "phoneVerified": true,
  "givenNames": "consider",
  "surname": "consider",
  "fullName": "consider consider",
  "preferredName": "string",
  "dateOfBirth": "1990-09-29",
  "onboardingStatus": "ADDRESS_CAPTURED",
  "customerStatus": "PROSPECT",
  "idStatus": "consider",
  "photoStatus": "consider",
  "addressStatus": "consider",
  "watchlistStatus": "consider",
  "warnings": [
    {
      "type": "ID"
    },
    {
      "type": "PHOTO"
    },
    {
      "type": "WATCHLIST"
    }
  ],
  "address": {
    "addressKey": "ff4357f2-3122-4f6b-b410-8ffd498b70e8",
    "line1": "Kingston road",
    "line2": "string",
    "town": "Kingston",
    "county": "",
    "country": "GBR",
    "postcode": "KT2 7LB",
    "verified": false
  }
}

    """

  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Prospect Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "dd6e0475-cb7e-400f-bd8f-a3be81180083"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "customerKey": "dd6e0475-cb7e-400f-bd8f-a3be81180083",
  "customerEmail": "johnlee@yopmail.com",
  "emailVerified": false,
  "phoneVerified": false,
  "onboardingStatus": "EMAIL_CAPTURED",
  "customerStatus": "PROSPECT",
  "idStatus": "none",
  "photoStatus": "none",
  "addressStatus": "none",
  "watchlistStatus": "none",
  "warnings": []
    }
    """


  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Deleted Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
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
  "customerStatus": "DELETED",
  "idStatus": "none",
  "photoStatus": "none",
  "addressStatus": "none",
  "watchlistStatus": "none",
  "warnings": []
    }
    """

  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Suspend Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "3e34cdc4-6dd4-4a69-b3dd-9719103fb486"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "customerKey": "3e34cdc4-6dd4-4a69-b3dd-9719103fb486",
  "customerEmail": "dublication6@yopmail.com",
  "emailVerified": true,
  "phoneVerified": false,
  "givenNames": "Sule",
  "surname": "Can",
  "fullName": "Sule Can",
  "dateOfBirth": "1989-09-09",
  "onboardingStatus": "NAME_DOB_CAPTURED",
  "customerStatus": "PROSPECT",
  "idStatus": "clear",
  "photoStatus": "clear",
  "addressStatus": "none",
  "watchlistStatus": "none",
  "warnings": []
  }
    """


  @getCustomerByKey
  Scenario: Get Customer By Customer Key for Agent - Fraud Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "2d8de573-90ab-4cde-8b17-2a7034d88eb3"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "customerKey": "2d8de573-90ab-4cde-8b17-2a7034d88eb3",
  "customerEmail": "onfido45@yopmail.com",
  "emailVerified": true,
  "phoneVerified": false,
  "givenNames": "consider",
  "surname": "consider",
  "fullName": "consider consider",
  "dateOfBirth": "1990-06-06",
  "onboardingStatus": "NAME_DOB_CAPTURED",
  "customerStatus": "FRAUD",
  "idStatus": "rejected",
  "photoStatus": "none",
  "addressStatus": "none",
  "watchlistStatus": "none",
  "warnings": []
  }
    """


  @getCustomerByKeyStatus401
  Scenario Outline: Get Customer By Key - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "efabacfb-9bed-4aa4-84e5-72418def8b0f"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |


  @getCustomerByKeyStatus400
  Scenario Outline: Get Customer By Customer Key for Agent - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
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
  Scenario Outline: Get Customer By Customer Key for Agent - Search by Key - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMzc3YmE5OC1lODdiLTQxZjMtYjBmOC0xMWYxZDUwYjA4ZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTkwNTg0MDgsImV4cCI6MTU5OTY2MzIwOH0.B10NIWYldecF4c7Lct83kLl9bBLkZsRcGaNs9oglVocT0EwJm9g8r7MYN7CgIbwvjAPbHwEC6c40w8Ddg-sOBw"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customer/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |

