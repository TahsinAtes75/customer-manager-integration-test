Feature: Contact Center - Get Customer Log Details

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerLogDetailsStatus401
  Scenario Outline: Get Customer Log Detail - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerLogDetailsStatus401
  Scenario: Get Customer Log Detail - Expired Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogDetailsStatus401
  Scenario: Get Customer Log Detail - Invalidated Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWE2OWE1Yy03ZTgwLTRjMmMtODNjNC0yMTNjNWNjZDdmZDYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTg1NzM4ODM3LCJleHAiOjE1ODYzNDM2Mzd9.fzt44FZUj18UGCKDDWusAfVXNOxoWAGV51C8OLINiUOQICqUpRFcw7PSkvufhgAqnRzPQIy5ofQ3YlGKYhF5CQ"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogDetailsStatus403
  Scenario: Get Customer Log Detail - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogDetailsStatus403
  Scenario: Get Customer Log Detail - Onboarding Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogDetailsStatus403
  Scenario: Get Customer Log Detail - Verification Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzNDc2NCwiZXhwIjoxODk2NTIwMzM0fQ.UEiqTrRtc4aza7soagRHv2rGBx7GBrFek93F_G981getKDSjD3ryF4hesdwdMP9I_Q4VdmL8tAQg_04-c4G_eA"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogDetailsStatus404
  Scenario Outline: Get Customer Log Detail - logId Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set path parameter "logId" with value "<logIdValue>"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 404
    And response body should contain value of "65021" for key "errors[0].code"
    And response body should contain value of "Customer log not found with id: <logIdValue>" for key "errors[0].description"
    Examples:
      | logIdValue |
      | 0          |
      | 1234567890 |


  @getCustomerLogDetailsStatus500
  Scenario Outline: Get Customer Log Detail - Invalid Path Parameter logId
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set path parameter "logId" with value "<logIdValue>"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 500
    Examples:
      | logIdValue |
      |            |
      | !@£$%^&*() |


  @getCustomerLogDetailsStatus400
  Scenario Outline: Get Customer Log Detail - Invalid logId
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set path parameter "logId" with value "<logIdValue>"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 400
    And response body should contain value of "65022" for key "errors[0].code"
    And response body should contain value of "Failed to convert value" for key "errors[0].description"
    Examples:
      | logIdValue |
      | asd        |
      | a          |
      | 1234qwert  |
      | ?          |


  @getCustomerLogDetailsStatus200
  Scenario: Get Customer Log Detail - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set path parameter "logId" with value "46"
    When I GET request to "/v1/customers/logs/{logId}"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "customerKey": "90254135-310a-4b58-bb49-dd2dcce2690a",
      "type": "EDIT_EMAIL",
      "oldValue": "{\"pendingEmail\":\"\"}",
      "newValue": "{\"pendingEmail\":\"onb_happy_path_6_3@hymnai.com\"}",
      "agentUsername": "AgentEbru",
      "createdAt": "2020-04-03T15:18:26"
    }
    """

