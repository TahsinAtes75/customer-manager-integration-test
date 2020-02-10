Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_happy_path_2@hymnai.com |
      | make     | Apple                       |
      | model    | iphone7                     |
      | serialNo | 12345                       |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_happy_path_2@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MTM1NTgyOCwiZXhwIjoxNTgxNDQyMjI4fQ.BbRNQc_k8029X0NkvKQ7gI1ZanusPfEK5-cn7DUJgCIh5Xirfp7Aeuds78IiriW5lBgxcwvcAJmuPYpr0-Pjqw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_2@hymnai.com",
      "onboardingStatus": "EMAIL_VERIFIED"
}
    """

    ###
    # Manually get the onboarding token from API with the verification token above
    ###
  @putNameAndDoBHappyPath
  Scenario: Put Name and DoB - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODEzNTU5ODQsImV4cCI6MTU4OTEzMTk4NH0.olH5gdA3olXbEION95n3Ff7qyFiQ0Uh70l9LGylnO5q4EPiev9qLI3Ua2gejbOr8P2O37Erdk1F8Sgp1NgxrmA"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_2@hymnai.com",
    "givenNames": "Ebru",
    "surname": "Soysal",
    "dateOfBirth": "1982-01-01",
    "onboardingStatus": "NAME_DOB_CAPTURED"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @putPhoneNumberHappyPath
  Scenario: Put Phone Number - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODEzNTU5ODQsImV4cCI6MTU4OTEzMTk4NH0.olH5gdA3olXbEION95n3Ff7qyFiQ0Uh70l9LGylnO5q4EPiev9qLI3Ua2gejbOr8P2O37Erdk1F8Sgp1NgxrmA"
    And I set request body with information given in the following table
      | phone | 448888888888 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_2@hymnai.com",
    "phone": "448888888888",
    "onboardingStatus": "TELEPHONE_CAPTURED"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  # Manually get the sms code from DB
  ###
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODEzNTU5ODQsImV4cCI6MTU4OTEzMTk4NH0.olH5gdA3olXbEION95n3Ff7qyFiQ0Uh70l9LGylnO5q4EPiev9qLI3Ua2gejbOr8P2O37Erdk1F8Sgp1NgxrmA"
    And I set query parameter "phone" with value "448888888888"
    And I set query parameter "code" with value "260238"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "onboardingStatus"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @captureAddressHappyPath
  Scenario: Capture Address - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODEzNTU5ODQsImV4cCI6MTU4OTEzMTk4NH0.olH5gdA3olXbEION95n3Ff7qyFiQ0Uh70l9LGylnO5q4EPiev9qLI3Ua2gejbOr8P2O37Erdk1F8Sgp1NgxrmA"
    And I set request body with information given in the following table
      | country  | UK             |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AP        |
      | town     | Reading        |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 200
    And response body should contain value of "ADDRESS_CAPTURED" for key "onboardingStatus"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @capturePasscodeHappyPath
  Scenario: Capture Passcode - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiNDQ4ZTA4Zi02MjcyLTQ2NjktOGNkYS00OGE4MDkyN2Y2OTEiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODEzNTU5ODQsImV4cCI6MTU4OTEzMTk4NH0.olH5gdA3olXbEION95n3Ff7qyFiQ0Uh70l9LGylnO5q4EPiev9qLI3Ua2gejbOr8P2O37Erdk1F8Sgp1NgxrmA"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 200
    And response body should contain value of "REGISTRATION_COMPLETE" for key "onboardingStatus"