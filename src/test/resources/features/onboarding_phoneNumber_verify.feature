Feature: Customer Onboarding - Verify Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "code" with value "504071"
    And I set query parameter "phone" with value "442222222222"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - SMS Code Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "code" for key "errors[0].field"
    And response body should contain value of "length must be 6" for key "errors[0].description"

    Examples:
      | smsValue |
      |          |
      | 123      |
      | 1234567  |



  @verifyPhoneNumberStatus400
  Scenario Outline: Verify Phone Number - Phone Number Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "584625"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "phone" for key "errors[0].field"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"

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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set query parameter "phone" with value "445554443332"
    And I set query parameter "code" with value "<smsValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "errors[0].code"
    And response body should contain value of "Could not verify" for key "errors[0].description"

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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZjU2NDc3Ny04OGQ1LTRhYjUtYmQ3Yi1hMzk1YzE5MzA1NGMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTQxMTIsImV4cCI6MTg5NjUyMDMzNH0.kQoUVn6gbPlNZin8bxySzqodui1wydUbQXENNrLc3GaHMC_GHIwD-fIZDgYIh0cGyEpDaKS0r77_OLYr7NE49Q"
    And I set query parameter "phone" with value "444444444444"
    And I set query parameter "code" with value "726306"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65012" for key "errors[0].code"
    And response body should contain value of "SMS code expired" for key "errors[0].description"



  @verifyPhoneNumberStatus401
  Scenario Outline: Verify Phone Number - Token, Phone, SmsCode do not match
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0MWUyZWEyYi0zMGE5LTQwZmMtYWI1Ni0xYjk2OTUwZDQwYzMiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3OTIyMjYsImV4cCI6MTg5NTk4MjY0Mn0.-25Rv0vmSErVr1ZwF328ErbsG-AGvtUb5eKO-TeuA8u97fsPpPpbSaNo1SwJHZ7qXRTLH1BtaYyQtLqV8A7buw"
    And I set query parameter "phone" with value "<phoneValue>"
    And I set query parameter "code" with value "<codeValue>"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "errors[0].code"
    And response body should contain value of "Could not verify" for key "errors[0].description"

    Examples:
      | phoneValue   | codeValue |
      | 442222222222 | 584624    |
      | 442222222221 | 584625    |

