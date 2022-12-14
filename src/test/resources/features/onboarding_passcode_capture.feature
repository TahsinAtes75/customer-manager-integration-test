Feature: Customer Onboarding - Capture Customer Passcode

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @capturePasscodeStatus401
  Scenario Outline: Put Name and DoB - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | phone | 447234567890 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |



  @capturePasscodeStatus400
  Scenario Outline: Customer Passcode - Passcode Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | passcode | <passcodeValue> |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "passcode" for key "validationErrors[0].field"
    And response body should contain value of "only digit and length must be 6" for key "validationErrors[0].message"

    Examples:
      | passcodeValue |
      |               |
      | 12345         |
      | 1234567       |
      | 123asd        |
      | qwerty        |
      | 12345@        |



  # Onboarding status is EMAIL_CAPTURED
  # Customer: onb_email_captured@hymnai.com
  # Onboarding token has been taken without verifying the email
  @capturePasscodeStatus400
  Scenario: Customer Passcode - Customer status
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMGFkMmJjOS1iYzk0LTRjMWQtYjViYi05MGRiYWY1YmY2ODMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM4MzU3MDYsImV4cCI6MTg5NjUyMDMzNH0.kZnQRZqxwf_BMHqLCAC6_4vojcv-Q_6rCnL-bfLMayHUSAyCiNiB4NAyE4s2OebBWr8RZiPRJv2VL7Sl7r6_jQ"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"
