Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | Sprint1Demo@hymnai.com |
      | make     | Apple                  |
      | model    | iphone7                |
      | serialNo | 12345                  |
    When I POST request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of "Sprint1Demo@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain value not equal to 0 for key "number"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the email verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "Sprint1Demo@hymnai.com"
    And I set query parameter "token" with value "dopc3wps2pwjdzwnzhgqgasyz8sznbi8mhvnrfyiafu2vi5el7fyorkan0nkmha2leadathlglet7dccoemvs2ai8xxffrisitfa9mhnlbbh9lvskeiowflnrn3utffk"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain the key "onboardingToken" with a not-null value
    And response body should be following json
    """
    {
      "email": "Sprint1Demo@hymnai.com",
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
    And I set path parameter "email" with value "Sprint1Demo@hymnai.com"
    And I set query parameter "token" with value "tr2wj5b57r72rhry9z3njjoab8l7ncy9a7yxyr0jl4pkftiifszpoesti9ffas9hg4gcxaoratyevkejhsiqentyormrlssfnai3flsungdfrgqtismkdy07gtodm6g5"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "Sprint1Demo@hymnai.com",
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
    And I set path parameter "email" with value "Sprint2Demo@hymnai.com"
    And I set query parameter "token" with value "akxjyh1pjs2ss0u9hsopdqnvqibp70z9kdecko0avsnvtrvezkqdfj1i6epshjyp5xu949zi2ysyki0igefcvqony6dvcbuirgwzkbgo1pgbw1ok1ci4vfkgoh7jmbqf"
    And I set request body with information given in the following table
      | phone | 447423829367 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "Sprint2Demo@hymnai.com",
    "phone": "447423829367",
    "status": "TELEPHONE_CAPTURED"
   }
  """

  ###
  # Manually get the phone number and sms code from DB
  ##
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set path parameter "email" with value "Sprint2Demo@hymnai.com"
    And I set query parameter "phone" with value "447423829367"
    And I set query parameter "code" with value "882987"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "status"


  @captureAddressHappyPath
  Scenario: Capture Address - Happy Path
    And I set request header content type as JSON
    And I set path parameter "email" with value "Sprint2Demo@hymnai.com"
    And I set query parameter "onboardingToken" with value "akxjyh1pjs2ss0u9hsopdqnvqibp70z9kdecko0avsnvtrvezkqdfj1i6epshjyp5xu949zi2ysyki0igefcvqony6dvcbuirgwzkbgo1pgbw1ok1ci4vfkgoh7jmbqf"
    And I set request body with information given in the following table
      | country  | UK                |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I POST request to "/v1/customers/{email}/addresses"
    Then response status code should be 200
    And response body should contain value of "ADDRESS_CAPTURED" for key "status"


  @capturePasscodeHappyPath
  Scenario: Capture Passcode - Happy Path
    And I set request header content type as JSON
    And I set path parameter "email" with value "Sprint2Demo@hymnai.com"
    And I set query parameter "onboardingToken" with value "akxjyh1pjs2ss0u9hsopdqnvqibp70z9kdecko0avsnvtrvezkqdfj1i6epshjyp5xu949zi2ysyki0igefcvqony6dvcbuirgwzkbgo1pgbw1ok1ci4vfkgoh7jmbqf"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/{email}/passcode"
    Then response status code should be 200
    And response body should contain value of "ACTIVE" for key "status"