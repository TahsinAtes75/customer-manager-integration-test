Feature: Customer Onboarding - Capture Customer Phone Number

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"
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
      | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmZGM2NmM1My0yM2M2LTQ4MDQtOWE5ZS1lODVkYjVkZGM2NzkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MDk5NzAsImV4cCI6MTg5NjUyMDMzNH0.yed3pYVacn_Md5ZVI4S8Qh70nbEXZ19nMhcnmp4ACf-STST3kwXmF9BufFR4q_uYmAvvUfUV3gLT4ew-FFCojA"
    And I set request body with information given in the following table
      | phone | 447000111101 |
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZTcyNGFhNi1kZTAxLTQxYWUtYThkZi02MzE1NmUwMjk2ZGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTAzODIsImV4cCI6MTg5NjUyMDMzNH0.9dJasgptjkX-QeY-pQMzTHO1TxAZkl4DbQJSrZUYNZzMKDoeHPBnVxglK0KE_lR6bfY6XsCa6h2lLZZmrMdpvw"
    And I set request body with information given in the following table
      | phone | 442222222222 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_resend_sms@hymnai.com",
    "phone": "442222222222",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzMzk4MDQyYi0xZDliLTQ5MmUtOTZlZS05YzcxNGJkZTcxNjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTM5MzAsImV4cCI6MTg5NjUyMDMzNH0.Uly9c7-l5bd5W7rfmn8NPWe994aU4a1Qk66XHeL57qg0335Wf_FOHxVC4Kv0vxyJK8WZ3UUqXgBZEef7GHVfAg"
    And I set request body with information given in the following table
      | phone | 443333333332 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

