Feature: Customer Onboarding - Capture Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"
    And I set request header content type as JSON


  @putPhoneNumberStatus401
  Scenario Outline: Put Name and DoB - Onboarding token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | phone | 447234567890 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @putPhoneNumberStatus400
  Scenario Outline: Put Phone Number - Invalid Phone Number
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set request body with information given in the following table
      | phone | <phoneValue> |
    When I PUT request to "/v1/customers/phone"
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


  @putPhoneNumberStatus409
  Scenario: Put Phone Number - Phone Number Already Exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI2MzcwNjdhOC02MWU0LTQ2MDktODIxNC0zYzYwYjBjYTcwZmUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzYyNzgsImV4cCI6MTg5NTk4MjY0Mn0.kX5uHr3HrMkMVnx4lTYPzyBlFl3-kMA5RffZYgbNfh4mT8DtwP3WzgZGdXiZ_jK2R9BS1r2mNMJiLMbgH_pwog"
    And I set request body with information given in the following table
      | phone | 441111111111 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 409
    And response body should contain value of "65010" for key "code"
    And response body should contain value of "Phone already exists" for key "message"


  @putPhoneNumberStatus404
  Scenario: Put Phone Number - Customer not found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2QyMjc2NC04MjcwLTQ0NTgtYmNjMC03NzVmYmNkYWU2YzIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1Nzk3Nzg0NDYsImV4cCI6MTg5NTk4MjY0Mn0.l6QRLkT-1lsEAHUoIR-71cNOVxpik_Jspbi3BLd-otu3IxXEaYpxUUV3XnAuVZEKheTQu0D-29ann3i0H4eFOw"
    And I set request body with information given in the following table
      | phone | 441111111111 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 404
    And response body should contain value of "65011" for key "code"
    And response body should contain value of "Customer not found with key: 93d22764-8270-4458-bcc0-775fbcdae6c2" for key "message"



  ###########################
  # Customer: onb_resend_sms@hymnai.com
  # Customer's status is "TELEPHONE_CAPTURED"
  # Manually get the Onboarding token from API
  ###########################
  @resendSmsCodeStatus200
  Scenario: Resend SMS Code
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIxYWUzYjk2YS0wOGRiLTRiYzktOWZiOS1lMDgyZmUzYjdhMTkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxNDIzOTQsImV4cCI6MTg5NTk4MjY0Mn0.jnmu3XCfOfhkRVj6PJnAoqRjw_3_wsIDXDr6_3e1TO4gshJEY8hVlHPidB_srqQllNsUjsP2ZhXN99rveZGH2w"
    And I set request body with information given in the following table
      | phone | 445555555555 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_resend_sms@hymnai.com",
    "phone": "445555555555",
    "status": "TELEPHONE_CAPTURED"
  }
  """


  ###########################
  # Customer: onb_address_captured@hymnai.com
  # Customer's status is other than "TELEPHONE_CAPTURED" or "NAME_DOB_CAPTURED"
  # Customer's status is "ADDRESS_CAPTURED"
  # Manually get the Onboarding token from API
  ###########################
  @resendSmsCodeStatus400
  Scenario: Resend SMS Code - Status is incompatible
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjZDM5M2IyYS1mMTNmLTRhMGItOWMyNi1hYWFiNzg1N2RiMGIiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxNDMyNzUsImV4cCI6MTg5NTk4MjY0Mn0.soqg9_SRkvJL4_L9nlPVHsAdizBP8fWhgVRIewzt64XCCg53yMpIho1q4BjNoBSzKViLLfcAAbgigHoMvh0lLw"
    And I set request body with information given in the following table
      | phone | 443333333332 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"

