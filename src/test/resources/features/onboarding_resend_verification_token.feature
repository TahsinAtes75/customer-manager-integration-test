Feature: Customer Onboarding - Resend Verification Token

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  ###################################
  ### Resend Verification Token only works for if Onboarding status is either "EMAIL_CAPTURED" OR "EMAIL_VERIFIED"
  ###################################

  @resendVerificationToken
  Scenario: Resend Verification Token - Onboarding Status EMAIL_CAPTURED
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_resend_token1@hymnai.com |
      | make     | Apple                        |
      | model    | iphone7                      |
      | serialNo | 12345                        |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_resend_token1@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"
    And response body should contain the key "key" with a not-null value


  # Manually get the latest verification token from DB for the given email.
  # Call Email Verification API to set onboarding status as "EMAIL_VERIFIED"
  @resendVerificationToken
  Scenario: Resend Verification Token - Onboarding Status EMAIL_VERIFIED
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_resend_token2@hymnai.com |
      | make     | Apple                        |
      | model    | iphone7                      |
      | serialNo | 12345                        |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_resend_token2@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "onboardingStatus"
    And response body should contain value of "PROSPECT" for key "customerStatus"
    And response body should contain the key "key" with a not-null value


  ###
  # After resend verification link "onb_resend_token2" customer becomes EMAIL_CAPTURED.
  # To be able to test this case for EMAIL_VERIFIED customer, it needs to be verified again.
  ###
  @verifyEmail
  Scenario: Verify Email - onb_resend_token2@hymnai.com
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzMDc5NTNhOS1lMDc0LTQ1ZDAtOTZhYy04MDVhYTQ3NmU3YTkiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzODQwMiwiZXhwIjoxODk2NTIwMzM0fQ.4WodbBoZMdO2wY_M_IkXyX93eq0s_YNrQwQZbmhU_eHt2G7dfXsWt24b8-YtygunG7d4TbaT7f8arYUSrxXORw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_resend_token2@hymnai.com",
      "onboardingStatus": "EMAIL_VERIFIED",
      "customerStatus": "PROSPECT"
}
    """


  #######
  # Onboarding status is ADDRESS_CAPTURED
  #######

  @resendVerificationTokenStatus400
  Scenario: Resend Verification Token - Onboarding status is incompatible
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_address_captured@hymnai.com |
      | make     | Apple                           |
      | model    | iphone7                         |
      | serialNo | 12345                           |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"
