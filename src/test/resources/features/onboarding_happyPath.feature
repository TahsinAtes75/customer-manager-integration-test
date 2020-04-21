Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_happy_path_8@hymnai.com |
      | make     | Apple                       |
      | model    | iphone7                     |
      | serialNo | 12345                       |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_happy_path_8@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwODkyYWM1Ny01M2VlLTQxMDktOGFhZC1iZmNkMzYyZjNhOGYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4NzA0NjI3MSwiZXhwIjoxNTg3MTMyNjcxfQ.1yhwSJjuBtDoz_yx8yUBZgvoaDoghZ1_Z-ITb9v2kaHi_qDgZz90wrFWYT7uJlbqaeS0L8KT0QIHg8rxd-VtAw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_8@hymnai.com",
      "onboardingStatus": "EMAIL_VERIFIED",
      "customerStatus": "PROSPECT"
}
    """

    ###
    # Manually get the onboarding token from API with the verification token above
    ###
  @putNameAndDoBHappyPath
  Scenario: Put Name and DoB - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYjJjZTc3NC1mODdmLTQ3M2QtOTQyNi04ODY5OTUyZDA1MmUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODcwNDY1MDksImV4cCI6MTU5NDgyMjUwOX0.TCSCdpq5DSr15bSuvPzFdYG4qHW0Ib4APrlbe9nJtso-UZw2Rmdjr7kd_s1oOG_7VTmpl9KbBnQrd2Fbk-XADQ"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_8@hymnai.com",
    "givenNames": "Ebru",
    "surname": "Soysal",
    "dateOfBirth": "1982-01-01",
    "onboardingStatus": "NAME_DOB_CAPTURED",
    "customerStatus": "PROSPECT"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @putPhoneNumberHappyPath
  Scenario: Put Phone Number - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYjJjZTc3NC1mODdmLTQ3M2QtOTQyNi04ODY5OTUyZDA1MmUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODcwNDY1MDksImV4cCI6MTU5NDgyMjUwOX0.TCSCdpq5DSr15bSuvPzFdYG4qHW0Ib4APrlbe9nJtso-UZw2Rmdjr7kd_s1oOG_7VTmpl9KbBnQrd2Fbk-XADQ"
    And I set request body with information given in the following table
      | phone | 443838383838 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_8@hymnai.com",
    "phone": "443838383838",
    "onboardingStatus": "TELEPHONE_CAPTURED",
    "customerStatus": "PROSPECT"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  # Manually get the sms code from DB
  ###
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYjJjZTc3NC1mODdmLTQ3M2QtOTQyNi04ODY5OTUyZDA1MmUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODcwNDY1MDksImV4cCI6MTU5NDgyMjUwOX0.TCSCdpq5DSr15bSuvPzFdYG4qHW0Ib4APrlbe9nJtso-UZw2Rmdjr7kd_s1oOG_7VTmpl9KbBnQrd2Fbk-XADQ"
    And I set query parameter "phone" with value "443838383838"
    And I set query parameter "code" with value "104924"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @captureAddressHappyPath
  Scenario: Capture Address - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYjJjZTc3NC1mODdmLTQ3M2QtOTQyNi04ODY5OTUyZDA1MmUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODcwNDY1MDksImV4cCI6MTU5NDgyMjUwOX0.TCSCdpq5DSr15bSuvPzFdYG4qHW0Ib4APrlbe9nJtso-UZw2Rmdjr7kd_s1oOG_7VTmpl9KbBnQrd2Fbk-XADQ"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AP        |
      | town     | Reading        |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 200
    And response body should contain value of "ADDRESS_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @capturePasscodeHappyPath
  Scenario: Capture Passcode - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYjJjZTc3NC1mODdmLTQ3M2QtOTQyNi04ODY5OTUyZDA1MmUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMWVjOTQyNi0wYjFkLTQ4YzMtYjVhYy02N2U3ZDMxYmI0NjEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODcwNDY1MDksImV4cCI6MTU5NDgyMjUwOX0.TCSCdpq5DSr15bSuvPzFdYG4qHW0Ib4APrlbe9nJtso-UZw2Rmdjr7kd_s1oOG_7VTmpl9KbBnQrd2Fbk-XADQ"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 200
    And response body should contain value of "REGISTRATION_COMPLETE" for key "onboardingStatus"
    And response body should contain value of "ACTIVE" for key "customerStatus"