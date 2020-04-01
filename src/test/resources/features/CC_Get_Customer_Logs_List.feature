Feature: Contact Center - Get Customer Logs List

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerLogsListStatus401
  Scenario Outline: Get Customer Logs List - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Expired Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Invalidated Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWE2OWE1Yy03ZTgwLTRjMmMtODNjNC0yMTNjNWNjZDdmZDYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTg1NzM4ODM3LCJleHAiOjE1ODYzNDM2Mzd9.fzt44FZUj18UGCKDDWusAfVXNOxoWAGV51C8OLINiUOQICqUpRFcw7PSkvufhgAqnRzPQIy5ofQ3YlGKYhF5CQ"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Onboarding Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Verification Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzNDc2NCwiZXhwIjoxODk2NTIwMzM0fQ.UEiqTrRtc4aza7soagRHv2rGBx7GBrFek93F_G981getKDSjD3ryF4hesdwdMP9I_Q4VdmL8tAQg_04-c4G_eA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  #### Will be tested after the bug BANK-1741 is fixed
  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - endDate Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "<endDateValue>"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 400
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Invalid End Date" for key "errors[0].description"
    Examples:
      | endDateValue     |
      |                  |
      | 123              |
      | 2020-04-01       |
      | 2020-04-01T      |
      | 2020-04-01T00:00 |


  #### Will be tested after the bug BANK-1741 is fixed
  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - startDate Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "<startDateValue>"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 400
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Invalid Start Date" for key "errors[0].description"
    Examples:
      | startDateValue   |
      |                  |
      | 123              |
      | 2020-04-01       |
      | 2020-04-01T      |
      | 2020-04-01T00:00 |



  #### Will be tested after the bug BANK-1741 is fixed
  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - endDate is smaller than startDate
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-02-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 401
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "endDate can not be smaller than startDate" for key "errors[0].description"


  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |



  #### Will be tested after the bug BANK-1742 is fixed
  @getCustomerLogsListStatus404
  Scenario Outline: Get Customer Logs List - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - sortBy Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "sortBy" with value "<sortByValue>"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "sortBy" for key "errors[0].field"
    And response body should contain value of "size must be between 1 and 50" for key "errors[0].description"

    Examples:
      | sortByValue                                         |
      |                                                     |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2opssdfsdfs |



  #### Will be tested after the bug BANK-1743 is fixed
  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Invalid sortBy Value
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "sortBy" with value "asd"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 401
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "Invalid sortBy Value" for key "errors[0].description"




  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Valid Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    When I GET request to "/v1/customers/logs"
    Then response status code should be 200
