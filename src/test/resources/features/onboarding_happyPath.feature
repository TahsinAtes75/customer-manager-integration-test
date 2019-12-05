Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"

  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | e.soysal@hymnai.com |
      | make     | Apple               |
      | model    | iphone7             |
      | serialNo | 12345               |
    When I POST request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of "e.soysal@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain value not equal to 0 for key "number"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the email verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "zczphnyvvziqsfd5pc0jrpzdy0f3b5bsukcc0jgx7ybqcqeckjvzzlzri6fvkeealju6ef7svxztpvmns1mjy2lqzkkoo4yevg17v41klq7uljcjwvfvydx1qzcpz0cl"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain the key "onboardingToken" with a not-null value
    And response body should be following json
    """
    {
      "email": "e.soysal@hymnai.com",
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
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "hx0fwpbux4zc4shxsgydrcsxwpqa2hz4s7psb5w7dfhp9xnugyiflgchrgrsnqeusmlbpf1gspydha2ztwlfmvfvfjj7b8ssxjgal4pfb6trmfrb5p2tk15ramixl1iz"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/{email}/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
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
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "hx0fwpbux4zc4shxsgydrcsxwpqa2hz4s7psb5w7dfhp9xnugyiflgchrgrsnqeusmlbpf1gspydha2ztwlfmvfvfjj7b8ssxjgal4pfb6trmfrb5p2tk15ramixl1iz"
    And I set request body with information given in the following table
      | phone | 445554443332 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
    "phone": "445554443332",
    "status": "TELEPHONE_CAPTURED"
   }
  """

  ###
  # Manually get the phone number and sms code from DB
  ##
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "phone" with value "445554443332"
    And I set query parameter "code" with value "475639"
    When I POST request to "/v1/customers/{email}/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "status"