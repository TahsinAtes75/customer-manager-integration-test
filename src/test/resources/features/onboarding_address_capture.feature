Feature: Customer Onboarding - Capture Customer Address

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @captureAddressStatus401
  Scenario Outline: Capture Address - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |



  @captureAddressStatus400
  Scenario Outline: Capture Address - Country Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | <countryValue>    |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "country" for key "validationErrors[0].field"
    And response body should contain value of "code is not acceptable" for key "validationErrors[0].message"

    Examples:
      | countryValue                                        |
      |                                                     |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom |
      | United Kingdom                                      |
      | ASD                                                 |
      | 123                                                 |
      | UK                                                  |
      | AB?                                                 |
      | GB                                                  |
      | 826                                                 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - County Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | <countyValue>     |
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
      | countyValue                          | fieldName | message                       |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkf | county    | size must be between 0 and 35 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Line1 Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | GBR          |
      | county   | Berkshire    |
      | line1    | <line1Value> |
      | line2    | line2        |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line1Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      |                                                                                                                                                                                                                                                                  | line1     | size must be between 1 and 255 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line1     | size must be between 1 and 255 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Line2 Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | GBR          |
      | county   | Berkshire    |
      | line1    | line1        |
      | line2    | <line2Value> |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line2Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line2     | size must be between 0 and 255 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - PostCode Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
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
      | postCodeValue | fieldName | message                      |
      |               | postCode  | size must be between 1 and 8 |
      | fsdfsfsfa     | postCode  | size must be between 1 and 8 |


  @captureAddressStatus400
  Scenario Outline: Capture Address - Town Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
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
      | townValue                            | fieldName | message                       |
      |                                      | town      | size must be between 1 and 35 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa s | town      | size must be between 1 and 35 |

  # Onboarding status is EMAIL_CAPTURED
  # Customer: onb_email_captured@hymnai.com
  # Onboarding token has been taken without verifying the email
  @captureAddressStatus400
  Scenario: Put Name and DoB - Email is not verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMGFkMmJjOS1iYzk0LTRjMWQtYjViYi05MGRiYWY1YmY2ODMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM4MzU3MDYsImV4cCI6MTg5NjUyMDMzNH0.kZnQRZqxwf_BMHqLCAC6_4vojcv-Q_6rCnL-bfLMayHUSAyCiNiB4NAyE4s2OebBWr8RZiPRJv2VL7Sl7r6_jQ"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   |                   |
      | line1    | 40 Caversham Road |
      | line2    | optional          |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"
