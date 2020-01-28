Feature: Customer Onboarding - Verify Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"


  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "code" with value "504071"
    And I set query parameter "phone" with value "442222222222"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - SMS Code Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "code" for key "validationErrors[0].field"
    And response body should contain value of "length must be 6" for key "validationErrors[0].message"

    Examples:
      | smsValue |
      |          |
      | 123      |
      | 1234567  |



  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - Phone Number Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0MWUyZWEyYi0zMGE5LTQwZmMtYWI1Ni0xYjk2OTUwZDQwYzMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3OTIyMjYsImV4cCI6MTU4NzU2ODIyNn0.xUZaU_eUnf6mbZ5KoV3iBBPZlj5I3MJuJeEZfc9HQRuIUZfxCt14XwqwxkBC6KI7In6NBLpjezAy3Zv_E6Vi5g"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "584625"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "phone" for key "validationErrors[0].field"
    And response body should contain value of "Invalid phone number" for key "validationErrors[0].message"

    Examples:
      | phoneValue    |
      |               |
      | 441           |
      | 4412345678900 |
      | 123456789012  |
      | 44qwertyuiop  |
      | qwertyuriopp  |



  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - SMS Code Not Verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTU4NzU1NDQ0Nn0.uro7mTcyhMjlyFmRGft_l9oYW9HOQOgMgIf79cE9hhAFNGeLMlUsVWH9VfgzHiFwcV5iGPnuBdixMzJAokywxA"
    And I set query parameter "phone" with value "445554443332"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"

    Examples:
      | smsValue |
      | qwerty   |
      | 111111   |



  #####
  # Customer: onb_sms_code_expired@hymnai.com
  # Onboarding Token, Phone, SMS Code are match. But SMS Code is expired.
  #####
  @verifyPhoneNumberStatus401
  Scenario: Verify Phone Number - SMS Code Expired
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTU4NzkxMzYyOX0.O_2qcM_7AGky_y7ekKeCxjE1NYaXxx--sGKrKmpqRARlmq65SJoonWXYZ-m8ksBkObn7MXnxx75JQIIhsCvR1w"
    And I set query parameter "phone" with value "443333333333"
    And I set query parameter "code" with value "045983"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65012" for key "code"
    And response body should contain value of "SMS code expired" for key "message"



  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - Token, Phone, SmsCode do not match
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0MWUyZWEyYi0zMGE5LTQwZmMtYWI1Ni0xYjk2OTUwZDQwYzMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3OTIyMjYsImV4cCI6MTU4NzU2ODIyNn0.xUZaU_eUnf6mbZ5KoV3iBBPZlj5I3MJuJeEZfc9HQRuIUZfxCt14XwqwxkBC6KI7In6NBLpjezAy3Zv_E6Vi5g"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "<codeValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"

    Examples:
      | phoneValue   | codeValue |
      | 442222222222 | 584624    |
      | 442222222221 | 584625    |

