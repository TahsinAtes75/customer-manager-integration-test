Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_happy_path_7@hymnai.com |
      | make     | Apple                       |
      | model    | iphone7                     |
      | serialNo | 12345                       |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_happy_path_7@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4Mzc2MTc3OSwiZXhwIjoxNTgzODQ4MTc5fQ.v1I399cloKfuoyzCe8U6Fmr2sBHvNr9pDJPHIc9kC-TQxjfqrjQLT7EF6jC8GO4CEebQn2LSJmeEN3aT6KSrog"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_7@hymnai.com",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM3NjE5OTQsImV4cCI6MTU5MTUzNzk5NH0.ePBnSjBuIg_YGjBKEt_JPRt4588mMAlFvrWsIrIJtEeKLBjnX9r3sJFHcf7YRXvE5E3TN8bMP5DLt2yVEsmnpQ"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_7@hymnai.com",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM3NjE5OTQsImV4cCI6MTU5MTUzNzk5NH0.ePBnSjBuIg_YGjBKEt_JPRt4588mMAlFvrWsIrIJtEeKLBjnX9r3sJFHcf7YRXvE5E3TN8bMP5DLt2yVEsmnpQ"
    And I set request body with information given in the following table
      | phone | 449191919197 |
    When I POST request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_7@hymnai.com",
    "phone": "449191919197",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM3NjE5OTQsImV4cCI6MTU5MTUzNzk5NH0.ePBnSjBuIg_YGjBKEt_JPRt4588mMAlFvrWsIrIJtEeKLBjnX9r3sJFHcf7YRXvE5E3TN8bMP5DLt2yVEsmnpQ"
    And I set query parameter "phone" with value "449191919197"
    And I set query parameter "code" with value "375380"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM3NjE5OTQsImV4cCI6MTU5MTUzNzk5NH0.ePBnSjBuIg_YGjBKEt_JPRt4588mMAlFvrWsIrIJtEeKLBjnX9r3sJFHcf7YRXvE5E3TN8bMP5DLt2yVEsmnpQ"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkNWY5ZTNkOC03MjVjLTQ1ZjYtOTk4Zi1mZjcyZGQxNWExMDAiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODM3NjE5OTQsImV4cCI6MTU5MTUzNzk5NH0.ePBnSjBuIg_YGjBKEt_JPRt4588mMAlFvrWsIrIJtEeKLBjnX9r3sJFHcf7YRXvE5E3TN8bMP5DLt2yVEsmnpQ"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 200
    And response body should contain value of "REGISTRATION_COMPLETE" for key "onboardingStatus"
    And response body should contain value of "ACTIVE" for key "customerStatus"