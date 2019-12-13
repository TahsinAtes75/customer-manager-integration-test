Feature: Customer Onboarding - Resend Verification Token

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  ###
  # Manually get the email verification token value from DB for the given email
  ###
  @verifyEmail
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "resendToken@hymnai.com"
    And I set query parameter "token" with value "edc5jpjpq1j4mkv1l1oxhznpkxqjeh0lsi9y4bfh48acfdsj9v7skpw2aqjwzbkpkfpvtkpaq9gqyesizinjxnh7mflemdedt5g6bll5euhhd8urgrvo5c36jqm9yod2"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain the key "onboardingToken" with a not-null value
    And response body should be following json
    """
    {
      "email": "resendToken@hymnai.com",
      "onboardingToken": "${json-unit.ignore}",
      "status": "EMAIL_VERIFIED"
}
    """

  ###################################
  ### Resend Verification Token only works for if customer's status is either "TELEPHONE_CAPTURED" OR "TELEPHONE_VERIFIED"
  ###################################
  @resendVerificationToken
  Scenario: Resend Verification Token - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | resendToken@hymnai.com |
      | make     | Apple                  |
      | model    | iphone7                |
      | serialNo | 12345                  |
    When I POST request to "/v1/customers"
    Then response status code should be 200
    And response body should contain value of "resendToken@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain value not equal to 0 for key "number"
    And response body should contain the key "key" with a not-null value


  @resendVerificationTokenStatus400
  Scenario: Resend Verification Token - Customer's status in incompatible
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | e.soysal@hymnai.com |
      | make     | Apple               |
      | model    | iphone7             |
      | serialNo | 12345               |
    When I POST request to "/v1/customers"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"
