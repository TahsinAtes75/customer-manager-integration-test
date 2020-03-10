Feature: Customer Onboarding - Capture Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @putPhoneNumberStatus401
  Scenario Outline: Put Name and DoB - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | phone | 447234567890 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |


  @putPhoneNumberStatus400
  Scenario Outline: Put Phone Number - Invalid Phone Number
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set request body with information given in the following table
      | phone | <phoneValue> |
    When I POST request to "/v1/customers/phone"
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


  # Customer: onb_name_DoB@hymnai.com
  @putPhoneNumberStatus409
  Scenario: Put Phone Number - Phone Number Already Exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4YTMwN2Y0OS03YTc3LTQ3ZDItOTY0NC1lOTQxZGQ2NjY0MjgiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM4MzU5MjcsImV4cCI6MTg5NjUyMDMzNH0.6To4qIsyhO_RhMpBFfWbqkzq7xJXfF-csPSj0f0muYHfudVF0DD_1z6o9Q41512BiKdJN-mD5loXWjZbyrsHng"
    And I set request body with information given in the following table
      | phone | 441112223334 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 409
    And response body should contain value of "65010" for key "errors[0].code"
    And response body should contain value of "Phone already exists" for key "errors[0].description"


  @putPhoneNumberStatus404
  Scenario: Put Phone Number - Customer not found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set request body with information given in the following table
      | phone | 441111111111 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: 93d22764-8270-4458-bcc0-775fbcdae6c2" for key "errors[0].description"



  ###########################
  # Customer: onb_resend_sms@hymnai.com
  # Onboarding status is "TELEPHONE_CAPTURED"
  # Manually get the Onboarding token from API
  ###########################
  @resendSmsCodeStatus200
  Scenario: Resend SMS Code
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0ZTAyMDYwNS0yNjQ4LTRiNzQtYjYzZC1kMzQ1Mjk0MWI0ZTAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM4MzY1MjksImV4cCI6MTg5NjUyMDMzNH0.wyrHYgqYO_wlDTYWG2yC-xKvCxoy3Ci1-efENSjhTxw0XEIwY8cYhGfTgTF6vgqBvDKG3aJo554K8Rlcxb1U9g"
    And I set request body with information given in the following table
      | phone | 441112223335 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_resend_sms@hymnai.com",
    "phone": "441112223335",
    "onboardingStatus": "TELEPHONE_CAPTURED",
    "customerStatus": "PROSPECT"
  }
  """


  ###########################
  # Customer: onb_address_captured@hymnai.com
  # Onboarding status is other than "TELEPHONE_CAPTURED" or "NAME_DOB_CAPTURED"
  # Onboarding status is "ADDRESS_CAPTURED"
  # Manually get the Onboarding token from API
  ###########################
  @resendSmsCodeStatus400
  Scenario: Resend SMS Code - Status is incompatible
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM4MzY3MzksImV4cCI6MTg5NjUyMDMzNH0.MXAvhvoTjK5A1SBvKIoU7AwdRRdJmj-y6GAP7yVTFbam01QNn5-NEH70AM8Gmrz7OIRWksyC5WwmemKRE1bP3g"
    And I set request body with information given in the following table
      | phone | 443333333332 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

