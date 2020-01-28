Feature: Customer Onboarding - Capture Customer Address

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"
    And I set request header content type as JSON


  @captureAddressStatus401
  Scenario Outline: Capture Address - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |



  @captureAddressStatus400
  Scenario Outline: Capture Address - Country Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTU4NzkxMzYyOX0.O_2qcM_7AGky_y7ekKeCxjE1NYaXxx--sGKrKmpqRARlmq65SJoonWXYZ-m8ksBkObn7MXnxx75JQIIhsCvR1w"
    And I set request body with information given in the following table
      | country  | <countryValue>    |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | countryValue                                        | fieldName | message                       |
      |                                                     | country   | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | country   | size must be between 1 and 50 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Line1 Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTU4NzkxMzYyOX0.O_2qcM_7AGky_y7ekKeCxjE1NYaXxx--sGKrKmpqRARlmq65SJoonWXYZ-m8ksBkObn7MXnxx75JQIIhsCvR1w"
    And I set request body with information given in the following table
      | country  | UK           |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line1Value                                          | fieldName | message                       |
      |                                                     | line1     | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | line1     | size must be between 1 and 50 |



  @captureAddressStatus400
  Scenario Outline: Capture Address - PostCode Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTU4NzkxMzYyOX0.O_2qcM_7AGky_y7ekKeCxjE1NYaXxx--sGKrKmpqRARlmq65SJoonWXYZ-m8ksBkObn7MXnxx75JQIIhsCvR1w"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | <postCodeValue>   |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | postCodeValue                                       | fieldName | message                       |
      |                                                     | postCode  | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | postCode  | size must be between 1 and 50 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Town Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTU4NzkxMzYyOX0.O_2qcM_7AGky_y7ekKeCxjE1NYaXxx--sGKrKmpqRARlmq65SJoonWXYZ-m8ksBkObn7MXnxx75JQIIhsCvR1w"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | RG1 7EB           |
      | town     | <townValue>       |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | townValue                                           | fieldName | message                       |
      |                                                     | town      | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | town      | size must be between 1 and 50 |


  # Customer's status is EMAIL_CAPTURED
  # Onboarding token has been taken without verifying the email
  @captureAddressStatus400
  Scenario: Put Name and DoB - Email is not verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4Nzk4NzAyN30.F_3u6idy5hKws9U4N8ACwUFl21mRBfNqmm7OSi3mMoaqz6tO-GjeGRjHCb5LQdk432nHtHlo3YCBvKTbyrN9bw"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | RG1 7EB           |
      | town     | <townValue>       |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"
