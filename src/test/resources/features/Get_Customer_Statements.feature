Feature: Get Customer Statements

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getCustomerStatementsStatus401
  Scenario Outline: Get Customer Statements - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getCustomerStatementsStatus401
  Scenario: Get Customer Statements - Invalidated Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlZTI4NjM2OC04ZDJkLTRiMWUtOTJjNS00NDJhYTVjODkzYWMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGZjZjI4Mi0wOThjLTRkM2ItOGQ0OC1mNjkyZDQzM2I3YWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg0NTE2LCJleHAiOjE1ODY3ODkzMTZ9.we8wqB4QOsGYsEdE_RnnST_ayvGQlkdbmJ84tPNG6xtPdv87-25LW5uJxApl0_Xzxm1GPT_dcBx4_il-p8YmMw"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @getCustomerStatementsStatus403
  Scenario: Get Customer Statements - Valid Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerStatementsStatus403
  Scenario: Get Customer Statements - Valid Onboarding Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerStatementsStatus403
  Scenario: Get Customer Statements - Valid Verification Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzNDc2NCwiZXhwIjoxODk2NTIwMzM0fQ.UEiqTrRtc4aza7soagRHv2rGBx7GBrFek93F_G981getKDSjD3ryF4hesdwdMP9I_Q4VdmL8tAQg_04-c4G_eA"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @getCustomerStatementsStatus400
  Scenario Outline: Get Customer Statements - Date Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWViNzIzMC04MzNhLTQ4NTItYmQzMi05NjIxZWZmMTA4OTEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTY0ODI2MS03NDVlLTRkYzEtOWZmZC00MzI2NDE3OGVjMWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg3NzE2LCJleHAiOjE5MDE3MTc0MTZ9.heafYYLmIbSyvqYBtR3Qf_uZzybeGnOR8tQXNHaWApwaPy2q4nLQk1Jgv48eRJ8B9Px64yiTEYS_o4UodsPRYw"
    And I set query parameter "date" with value "<dateValue>"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 400
    And response body should contain value of "65022" for key "errors[0].code"
    And response body should contain value of "Failed to convert value" for key "errors[0].description"
    Examples:
      | dateValue  |
      | 123        |
      | asdd       |
      | 01-01-2017 |
      | 20200101   |
      | 2017.01.01 |


  @getCustomerStatementsStatus500
  Scenario: Get Customer Statements - Empty Date
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWViNzIzMC04MzNhLTQ4NTItYmQzMi05NjIxZWZmMTA4OTEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTY0ODI2MS03NDVlLTRkYzEtOWZmZC00MzI2NDE3OGVjMWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg3NzE2LCJleHAiOjE5MDE3MTc0MTZ9.heafYYLmIbSyvqYBtR3Qf_uZzybeGnOR8tQXNHaWApwaPy2q4nLQk1Jgv48eRJ8B9Px64yiTEYS_o4UodsPRYw"
    And I set query parameter "date" with value ""
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 500


  @getCustomerStatementsStatus400
  Scenario Outline: Get Customer Statements - fileName Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWViNzIzMC04MzNhLTQ4NTItYmQzMi05NjIxZWZmMTA4OTEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTY0ODI2MS03NDVlLTRkYzEtOWZmZC00MzI2NDE3OGVjMWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg3NzE2LCJleHAiOjE5MDE3MTc0MTZ9.heafYYLmIbSyvqYBtR3Qf_uZzybeGnOR8tQXNHaWApwaPy2q4nLQk1Jgv48eRJ8B9Px64yiTEYS_o4UodsPRYw"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "<fileNameValue>"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "size must be between 36 and 2147483647" for key "errors[0].description"
    Examples:
      | fileNameValue |
      |               |
      | 123           |
      | adaas         |


  @getCustomerStatementsStatus400
  Scenario Outline: Get Customer Statements - fileName and Customer Token not match
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWViNzIzMC04MzNhLTQ4NTItYmQzMi05NjIxZWZmMTA4OTEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTY0ODI2MS03NDVlLTRkYzEtOWZmZC00MzI2NDE3OGVjMWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg3NzE2LCJleHAiOjE5MDE3MTc0MTZ9.heafYYLmIbSyvqYBtR3Qf_uZzybeGnOR8tQXNHaWApwaPy2q4nLQk1Jgv48eRJ8B9Px64yiTEYS_o4UodsPRYw"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "<fileNameValue>"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 400
    And response body should contain value of "65020" for key "errors[0].code"
    And response body should contain value of "Customer not authorized to download requested statement" for key "errors[0].description"
    Examples:
      | fileNameValue                                       |
      | deneme deneme demejkdjksjfkjjjkshdfks               |
      | 12345678-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf |



  @getCustomerStatementsStatus200
  Scenario: Get Customer Statements - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1OWViNzIzMC04MzNhLTQ4NTItYmQzMi05NjIxZWZmMTA4OTEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTY0ODI2MS03NDVlLTRkYzEtOWZmZC00MzI2NDE3OGVjMWEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg2MTg3NzE2LCJleHAiOjE5MDE3MTc0MTZ9.heafYYLmIbSyvqYBtR3Qf_uZzybeGnOR8tQXNHaWApwaPy2q4nLQk1Jgv48eRJ8B9Px64yiTEYS_o4UodsPRYw"
    And I set query parameter "date" with value "2017-01-01"
    And I set query parameter "fileName" with value "35a51263-9ac6-362e-95d2-03a560fe3b42_01-01-2017.pdf"
    When I GET request to "/v1/customers/statements"
    Then response status code should be 200



