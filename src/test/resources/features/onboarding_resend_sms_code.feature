Feature: Customer Onboarding - Resend SMS Code

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  ###########################
  # Customer's status is "TELEPHONE_CAPTURED"
  # SMS code is not expired
  # Manually get the onboarding token from DB for the given email
  ###########################
  @resendSmsCodeNotExpired
  Scenario: Resend SMS Code - Previous SMS Code is not Expired
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "lnar3nf2vzjomsahn4ewrt4kb5slh6kwniyduo7twbnaa7zgc6pmcklhywx7mehumpx9nkxxxqcvxoxynoidhdpk4g1x0bindvzrh3xkqxswswq5mpkhdqswiycl5dgz"
    And I set request body with information given in the following table
      | phone | 447423829367 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
    "phone": "447423829367",
    "status": "TELEPHONE_CAPTURED"
   }
  """


  @resendSmsCodeExpired
  Scenario: Resend SMS Code - Previous SMS Code is Expired
    And I set path parameter "email" with value "e.soysal@hymnai.com"
    And I set query parameter "token" with value "lnar3nf2vzjomsahn4ewrt4kb5slh6kwniyduo7twbnaa7zgc6pmcklhywx7mehumpx9nkxxxqcvxoxynoidhdpk4g1x0bindvzrh3xkqxswswq5mpkhdqswiycl5dgz"
    And I set request body with information given in the following table
      | phone | 447423829367 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "e.soysal@hymnai.com",
    "phone": "447423829367",
    "status": "TELEPHONE_CAPTURED"
   }
  """


  ###########################
  # Customer's status is other than "TELEPHONE_CAPTURED" or "NAME_DOB_CAPTURED"
  # Manually get the onboarding token from DB for the given email
  ###########################
  @resendSmsCodeStatus400
  Scenario: Resend SMS Code - Status is incompatible
    And I set path parameter "email" with value "Sprint3test@hymnai.com"
    And I set query parameter "token" with value "cnetgu8njizvvfm1nsb8b7aq3zp5lidfsxgfmbdcawkpoqlcd2g0onymkkp4gqbgwkre3vi5zpxkfbilx5nevdmytkv1kxpe3mg6e2qygbxmw1memlpvl9tbkjooaxdb"
    And I set request body with information given in the following table
      | phone | 447777777777 |
    When I PUT request to "/v1/customers/{email}/phone"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"

