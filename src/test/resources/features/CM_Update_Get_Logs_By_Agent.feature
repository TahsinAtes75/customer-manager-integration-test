Feature: Contact Center -  Update Get Logs By Agent

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerLogsListStatus401
  Scenario Outline: Get Customer Logs List - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Expired Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogsListStatus401
  Scenario: Get Customer Logs List - Invalidated Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWE2OWE1Yy03ZTgwLTRjMmMtODNjNC0yMTNjNWNjZDdmZDYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTg1NzM4ODM3LCJleHAiOjE1ODYzNDM2Mzd9.fzt44FZUj18UGCKDDWusAfVXNOxoWAGV51C8OLINiUOQICqUpRFcw7PSkvufhgAqnRzPQIy5ofQ3YlGKYhF5CQ"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerLogsListStatus403
  Scenario: Get Customer Logs List - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogsListStatus403
  Scenario: Get Customer Logs List - Onboarding Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerLogsListStatus403
  Scenario: Get Customer Logs List - Verification Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzNDc2NCwiZXhwIjoxODk2NTIwMzM0fQ.UEiqTrRtc4aza7soagRHv2rGBx7GBrFek93F_G981getKDSjD3ryF4hesdwdMP9I_Q4VdmL8tAQg_04-c4G_eA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"



  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - endDate Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "<endDateValue>"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65022" for key "errors[0].code"
    And response body should contain value of "Failed to convert value" for key "errors[0].description"
    Examples:
      | endDateValue     |
      | 123              |
      | asd              |
      | 2020.04.01       |
      | 2020-04-01       |
      | 2020-04-01T      |
      | 2020-04-01T00    |




  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - startDate Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "<startDateValue>"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65022" for key "errors[0].code"
    And response body should contain value of "Failed to convert value" for key "errors[0].description"
    Examples:
      | startDateValue   |
      | 123              |
      | asd              |
      | 2020.04.01       |
      | 2020-04-01       |
      | 2020-04-01T      |
      | 2020-04-01T00    |



  @getCustomerLogsListStatus400
  Scenario: Get Customer Logs List - endDate is smaller than startDate
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-02-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65023" for key "errors[0].code"
    And response body should contain value of "Start date should not after end date" for key "errors[0].description"


  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "<keyValue>"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+deadline"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @getCustomerLogsListStatus400
  Scenario Outline: Get Customer Logs List - sortBy Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "40cf94dc-dc4b-468c-bf67-d69530e85bf7"
    And I set query parameter "endDate" with value "2020-04-01T00:00:00"
    And I set query parameter "startDate" with value "2020-03-01T00:00:00"
    And I set header "key" parameter with value "24fba069-ed4d-4894-b997-00d0038d3abf"
    And I set query parameter "limit" with value "100"
    And I set query parameter "offset" with value "0"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    And I set query parameter "sortBy" with value "<sortByValue>"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "sortBy" for key "errors[0].field"
    And response body should contain value of "size must be between 1 and 50" for key "errors[0].description"

    Examples:
      | sortByValue                                         |
      |                                                     |
      | qwertyuiopasdfghjklqwertyuioqwasqwertyui2opssdfsdfs |



  @getCustomerLogsListStatus400
  Scenario: Get Customer Logs List - Invalid sortBy Value
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "key" parameter with value "1d078f53-6339-4a22-898a-cb83caedf33e"
    And I set query parameter "sortBy" with value "asd"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 400
    And response body should contain value of "65023" for key "errors[0].code"
    And response body should contain value of "Sort column not found" for key "errors[0].description"


  @getCustomerLogsListStatus200
  Scenario: Get Customer Logs List - Valid Agent Token-1
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "key" parameter with value "1d078f53-6339-4a22-898a-cb83caedf33e"
    And I set query parameter "types" with value "CREATE_CUSTOMER"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "contents": [
    {
      "id": 7856,
      "type": "CREATE_CUSTOMER",
      "createdAt": "2020-08-18T13:17:38"
    }
  ]
}
    """

  @getCustomerLogsListStatus200
  Scenario: Get Customer Logs List - Valid Agent Token-2
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "key" parameter with value "1d078f53-6339-4a22-898a-cb83caedf33e"
    And I set query parameter "types" with value "CREATE_DEVICE"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "contents": [
    {
      "id": 7857,
      "type": "CREATE_DEVICE",
      "createdAt": "2020-08-18T13:17:38"
    }
  ]
}
    """

  @getCustomerLogsListStatus200
  Scenario: Get Customer Logs List - Valid Agent Token-3
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "key" parameter with value "1d078f53-6339-4a22-898a-cb83caedf33e"
    When I GET request to "/v1/customers/logs/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "totalPages": 1,
  "contents": [
    {
      "id": 7856,
      "type": "CREATE_CUSTOMER",
      "createdAt": "2020-08-18T13:17:38"
    },
    {
      "id": 7857,
      "type": "CREATE_DEVICE",
      "createdAt": "2020-08-18T13:17:38"
    },
    {
      "id": 7858,
      "type": "VERIFY_EMAIL",
      "createdAt": "2020-08-18T13:17:57"
    },
    {
      "id": 7859,
      "type": "CAPTURE_TELEPHONE",
      "createdAt": "2020-08-18T13:19:25"
    },
    {
      "id": 7860,
      "type": "VERIFY_TELEPHONE",
      "createdAt": "2020-08-18T13:19:58"
    },
    {
      "id": 7861,
      "type": "CAPTURE_PASSCODE",
      "createdAt": "2020-08-18T13:20:15"
    },
    {
      "id": 7862,
      "type": "CAPTURE_NAME_DOB",
      "createdAt": "2020-08-18T13:21:24"
    },
    {
      "id": 7863,
      "type": "EDIT_ADDRESS",
      "createdAt": "2020-08-18T13:22:38"
    },
    {
      "id": 7864,
      "type": "EDIT_ADDRESS",
      "createdAt": "2020-08-18T13:22:38"
    },
    {
      "id": 8369,
      "type": "EDIT_EMAIL",
      "agentUsername": "AgentCat",
      "createdAt": "2020-08-28T14:17:27"
    },
    {
      "id": 8371,
      "type": "VERIFY_EMAIL",
      "createdAt": "2020-08-28T14:30:33"
    }
  ]
}
    """
