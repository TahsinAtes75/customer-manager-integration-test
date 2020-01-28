Feature: Customer Onboarding - Capture Customer Name and Date of Birth

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"
    And I set request header content type as JSON


  @putNameAndDoBStatus401
  Scenario Outline: Put Name and DoB - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | 1980-01-01      |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |



  #####
  ##### Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  #####
  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Given Names Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set request body with information given in the following table
      | givenNames  | <givenNamesValue> |
      | surname     | Surname Surname   |
      | dateOfBirth | 1980-11-15        |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | givenNamesValue                                     | fieldName  | message                       |
      |                                                     | givenNames | size must be between 1 and 50 |
      | as123asdsdwewe123as d123assdasd123 asd1asdsdfsfsfsr | givenNames | size must be between 1 and 50 |


  #####
  ##### Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  #####
  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Surname Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set request body with information given in the following table
      | givenNames  | Name Name      |
      | surname     | <surnameValue> |
      | dateOfBirth | 1980-11-15     |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | surnameValue                                        | fieldName | message                       |
      |                                                     | surname   | size must be between 1 and 50 |
      | as123asdsdwewe123as d123assdasd123 asd1asdsdfsfsfsr | surname   | size must be between 1 and 50 |


  #####
  ##### Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  #####
  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Date of Birth Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | <DoBValue>      |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 400
    And response body should contain value of "65004" for key "code"
    And response body should contain value of "Http Message Not Readable" for key "message"

    Examples:
      | DoBValue    |
      | asdf        |
      | 1980        |
      | 1980-11     |
      | 1980-13-01  |
      | 1980-112-01 |
      | 1980-1-01   |
      | 1980-12-32  |
      | 1983-01-123 |
      | 1983-01-1   |
      | 1983-02-29  |
      | 1983-04-31  |



  #####
  ##### Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  #####
  @putNameAndDoBStatus400
  Scenario Outline: Put Name and DoB - Date of Birth Rules Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | <DoBValue>      |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | DoBValue   | fieldName   | message                              |
      |            | dateOfBirth | Date can not be empty                |
      | 1899-11-15 | dateOfBirth | Age must be 120 years old or younger |
      | 2030-01-01 | dateOfBirth | Date can not be a future date        |
      | 2010-01-01 | dateOfBirth | Age must be 18 years old or older    |



  # Customer's status is EMAIL_CAPTURED
  # Onboarding token has been taken without verifying the email
  @putNameAndDoBStatus400
  Scenario: Put Name and DoB - Email is not verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4Nzk4NzAyN30.F_3u6idy5hKws9U4N8ACwUFl21mRBfNqmm7OSi3mMoaqz6tO-GjeGRjHCb5LQdk432nHtHlo3YCBvKTbyrN9bw"
    And I set request body with information given in the following table
      | givenNames  | Name Name       |
      | surname     | Surname Surname |
      | dateOfBirth | 1980-01-01      |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"
