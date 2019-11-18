Feature: Customer Onboarding - Verify Email Notification Token

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"


   ##
    # Manually get the token value from DB for the given email address
    # Manually check DB if the status has been updated, verification token has been deleted and onboarding token has been assigned

  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set path parameter "email" with value "ebru@trial.com"
    And I set query parameter "token" with value "zpdbciaq7i1iicieiczrbzbx48miwkrhdhp5fuwn4vvsmskzn1ajxte3ij1mk13kgnrlfengzuivqvjvh9bjhuyfkwruxbil3u4lebd6j94swumpz6bdyesqqlhhcrgg"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 200
    And response body should contain the key "onboardingToken" with a not-null value
    And response body should be following json
    """
    {
      "email": "ebru@trial.com",
      "onboardingToken": "${json-unit.ignore}",
      "status": "EMAIL_VERIFIED"
}
    """


  @verifyEmailStatus401
  Scenario: Verify Email - Email and Token not match
    And I set path parameter "email" with value "dccd@fvfvf.com"
    And I set query parameter "token" with value "trashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTokentrashTok"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"


  # Manually update the verification expiry date for the given email and verification token
  @verifyEmailStatus401
  Scenario: Verify Email - Verification code expired
    And I set path parameter "email" with value "sample1@mobqa.com"
    And I set query parameter "token" with value "wtqtiaegrowngx467ufdakkriivcdoz0ese3z512cd7f8rlobqpf1nemwnd0m9dply2offg9zj4mcdnn0f4i3tm1zoax0x3wygfmk4fopbfd7d9h5ga7peakwhgbj0q4"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 401
    And response body should contain value of "65002" for key "code"
    And response body should contain value of "Could not verify" for key "message"


  @verifyEmailStatus400
  Scenario Outline: Verify Email - Verification Token Validation Test
    And I set path parameter "email" with value "asd@asd.com"
    And I set query parameter "token" with value "<tokenValue>"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | tokenValue                                                                                                                        | fieldName | message            |
      |                                                                                                                                   | token     | length must be 128 |
      | asd                                                                                                                               | token     | length must be 128 |
      | asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsfs | token     | length must be 128 |


  @verifyEmailStatus400
  Scenario Outline: Verify Email - Email Validation Test
    And I set path parameter "email" with value "<emailValue>"
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 400
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  @verifyEmailStatus404
  Scenario: Verify Email - Empty Email Validation Test
    And I set path parameter "email" with value ""
    And I set query parameter "token" with value "asd123asd123asd123asd123asd123asd123asd123asd123asdasd123asd123asd123asd123asd123asd123asd123asd123asdasd123asdfsdfsdfsfsfsfsfsf"
    When I POST request to "/v1/customers/{email}/verify"
    Then response status code should be 404
