Feature: Customer Onboarding - Resend Verification Token

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"

  ###################################
  ### Resend Verification Token only works for if customer's status is either "EMAIL_CAPTURED" OR "EMAIL_VERIFIED"
  ###################################

  @resendVerificationToken
  Scenario: Resend Verification Token - Status EMAIL_CAPTURED
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_resend_token1@hymnai.com |
      | make     | Apple                        |
      | model    | iphone7                      |
      | serialNo | 12345                        |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_resend_token1@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain the key "key" with a not-null value


  # Manually get the latest verification token from DB for the given email.
  # Call Email Verification API to set customer's status as "EMAIL_VERIFIED"
  @resendVerificationToken
  Scenario: Resend Verification Token - Status EMAIL_VERIFIED
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_resend_token2@hymnai.com |
      | make     | Apple                        |
      | model    | iphone7                      |
      | serialNo | 12345                        |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_resend_token2@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain the key "key" with a not-null value



  #######
  # Customer's status is ADDRESS_CAPTURED
  #######

  @resendVerificationTokenStatus400
  Scenario: Resend Verification Token - Customer's status is incompatible
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_address_captured@hymnai.com |
      | make     | Apple                           |
      | model    | iphone7                         |
      | serialNo | 12345                           |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"
