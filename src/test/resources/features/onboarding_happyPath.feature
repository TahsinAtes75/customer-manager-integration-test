Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_happy_path_3@hymnai.com |
      | make     | Apple                       |
      | model    | iphone7                     |
      | serialNo | 12345                       |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_happy_path_3@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MTU5MDc3MCwiZXhwIjoxNTgxNjc3MTcwfQ.AoGHLFXYcxz_Fs9nU_FFC8Q_uWkEDke7iqfi3h49P_T-4aoWDH3BlS5Hh6Gi0sBvoXpa6DFVOrSQ518ajnc_LQ"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_3@hymnai.com",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODE1OTA4NjEsImV4cCI6MTU4OTM2Njg2MX0.soLm2R56f-r2fQEqb6eIiFaQGgdsQaUKSEH7Z-NQacJQd8S8RsBugzqNfAYrXOIp7M8xSPaPNnwwAz2SN16y8Q"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_3@hymnai.com",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODE1OTA4NjEsImV4cCI6MTU4OTM2Njg2MX0.soLm2R56f-r2fQEqb6eIiFaQGgdsQaUKSEH7Z-NQacJQd8S8RsBugzqNfAYrXOIp7M8xSPaPNnwwAz2SN16y8Q"
    And I set request body with information given in the following table
      | phone | 447777777777 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_3@hymnai.com",
    "phone": "447777777777",
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODE1OTA4NjEsImV4cCI6MTU4OTM2Njg2MX0.soLm2R56f-r2fQEqb6eIiFaQGgdsQaUKSEH7Z-NQacJQd8S8RsBugzqNfAYrXOIp7M8xSPaPNnwwAz2SN16y8Q"
    And I set query parameter "phone" with value "447777777777"
    And I set query parameter "code" with value "738448"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODE1OTA4NjEsImV4cCI6MTU4OTM2Njg2MX0.soLm2R56f-r2fQEqb6eIiFaQGgdsQaUKSEH7Z-NQacJQd8S8RsBugzqNfAYrXOIp7M8xSPaPNnwwAz2SN16y8Q"
    And I set request body with information given in the following table
      | country  | UK             |
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiYmVkOTZiOC03NDdkLTRkOTgtOTE5Yi1jMTFkYjk3ZGYxODkiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODE1OTA4NjEsImV4cCI6MTU4OTM2Njg2MX0.soLm2R56f-r2fQEqb6eIiFaQGgdsQaUKSEH7Z-NQacJQd8S8RsBugzqNfAYrXOIp7M8xSPaPNnwwAz2SN16y8Q"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 200
    And response body should contain value of "REGISTRATION_COMPLETE" for key "onboardingStatus"
    And response body should contain value of "ACTIVE" for key "customerStatus"