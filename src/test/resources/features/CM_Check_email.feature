Feature: Customer Service - Check Email

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  @checkEmailStatus400
  Scenario Outline: Check Email - Email Validation Test
    And I set request body with information given in the following table
      | email    | <email>  |

    When I POST request to "/v1/customer/email/check"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | email                                               | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      |                                                     | email     | size must be between 6 and 50       |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |

  @checkEmailStatus200
  Scenario:Check Email - Check Email happy path with current customer
    And I set request body with information given in the following json
   """
   {
    "email": "test77@yopmail.com"
   }
   """
    When I POST request to "/v1/customer/email/check"
    Then response status code should be 200
    And response body should be following json
   """
  {
  "email": "test77@yopmail.com",
  "exist": true
  }
   """

#If the customer is current customer it means customer email exist from DB(exist value is true)

  @checkEmailStatus200
  Scenario:Check Email - Check Email happy path with new customer
    And I set request body with information given in the following json
   """
   {
    "email": "test100@yopmail.com"
   }
   """
    When I POST request to "/v1/customer/email/check"
    Then response status code should be 200
    And response body should be following json
   """
  {
  "email": "test100@yopmail.com",
  "exist": false
  }
   """


#If the customer is new customer it means customer email does not exist from DB(exist value is false)


  @checkEmailStatus400
  Scenario Outline: Check Email - Email Validation Test for customer onboarding status
    And I set request body with information given in the following table
      | email    | <email>  |

    When I POST request to "/v1/customer/email/check"
    Then response status code should be 200

    Examples:
      | email                         |
      | testuser043@yopmail.com       |
      | johnlee4@yopmail.com          |
      | qwedsa502@yopmail.com         |
      | testuser010@yopmail.com       |
      | testuser_002@yopmail.com      |


  # This api checks for all customers with all states (active, onboarding, etc...)
  #Onboarding Status:
  #EMAIL_VERIFIED
  #EMAIL_CAPTURED
  #NAME_DOB_CAPTURED
  #TELEPHONE_CAPTURED
  #TELEPHONE_VERIFIED