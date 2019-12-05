Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | testSprint2@hymnai.com |
      | make     | Apple               |
      | model    | iphone7             |
      | serialNo | 12345               |
    When I POST request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of "testSprint2@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain value not equal to 0 for key "number"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the email verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "token" with value "xt3q6xoie8icr53rdivl7i9drnxy8brzdvtzfpwdds3fzqgjp82ufmpbyntginq7jarizuf7brrgygmuhdzfl3zivjlytvdg28buengaslqswrumpyjahezrwxebryv1"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain the key "onboardingToken" with a not-null value
    And response body should be following json
    """
    {
      "email": "testSprint2@hymnai.com",
      "onboardingToken": "${json-unit.ignore}",
      "status": "EMAIL_VERIFIED"
}
    """

    ###
    # Manually get the onboarding token from DB for the given email
    ###
  @putNameAndDoBHappyPath
  Scenario: Put Name and DoB - Happy Path
    And I set request header content type as JSON
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "token" with value "osdvdgueu6xa8phswtkqm96ugtwwmq4b3mne1gn1b2oljphdju1hbhlaonuqpnbc7fczhp17ipzqk454dtipdny6hiyshfozzxmgw8zfsfte3twst0aw8dbzvau3ehlg"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "testSprint2@hymnai.com",
    "givenNames": "Ebru",
    "surname": "Soysal",
    "dateOfBirth": "1982-01-01",
    "status": "NAME_DOB_CAPTURED"
   }
  """

  ###
  # Manually get the onboarding token from DB for the given email
  ###
  @putPhoneNumberHappyPath
  Scenario: Put Phone Number - Happy Path
    And I set request header content type as JSON
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "token" with value "osdvdgueu6xa8phswtkqm96ugtwwmq4b3mne1gn1b2oljphdju1hbhlaonuqpnbc7fczhp17ipzqk454dtipdny6hiyshfozzxmgw8zfsfte3twst0aw8dbzvau3ehlg"
    And I set request body with information given in the following table
      | phone | 441234567890 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "testSprint2@hymnai.com",
    "phone": "441234567890",
    "status": "TELEPHONE_CAPTURED"
   }
  """

  ###
  # Manually get the phone number and sms code from DB
  ##
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "phone" with value "441234567890"
    And I set query parameter "code" with value "725885"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "status"


  @captureAddressHappyPath
  Scenario: Capture Address - Happy Path
    And I set request header content type as JSON
    And I set path parameter "email" with value "testSprint2@hymnai.com"
    And I set query parameter "onboardingToken" with value "osdvdgueu6xa8phswtkqm96ugtwwmq4b3mne1gn1b2oljphdju1hbhlaonuqpnbc7fczhp17ipzqk454dtipdny6hiyshfozzxmgw8zfsfte3twst0aw8dbzvau3ehlg"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 200
    And response body should contain value of "ADDRESS_CAPTURED" for key "status"