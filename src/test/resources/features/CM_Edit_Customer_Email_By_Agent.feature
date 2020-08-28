Feature: Contact Center - Edit Customer's Email By Agent

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @ccEditEmailStatus401
  Scenario Outline: CC Edit Email By Agent - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@asd.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @ccEditEmailStatus401
  Scenario: CC Edit Email By Agent - Expired Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@asd.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @ccEditEmailStatus403
  Scenario: CC Edit Email By Agent - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email By Agent - customerKey Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "customerKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @ccEditEmailStatus404
  Scenario Outline: CC Edit Email By Agent - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email By Agent - Email Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "fafd64b8-9b70-48fe-960e-7051f3ed7b77"
    And I set request body with information given in the following table
      | email | <emailValue> |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | emailValue                                          | fieldName | message                             |
      |                                                     | email     | size must be between 6 and 50       |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |



  # Customer: onb_happy_path_4@hymnai.com
  # Try to change the email address as 'onb_email_captured@hymnai.com' or 'onb_happy_path_5@hymnai.com' which are already existed
  # When customer tries to update their email address with the same one, we return the same error
  @ccEditEmailStatus409
  Scenario Outline: CC Edit Email By Agent - Email already exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "3a581f48-4c1d-404e-a2ed-378395bd7dd2"
    And I set request body with information given in the following table
      | email | <emailValue> |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 409
    And response body should contain value of "65016" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same email. Please call Contact Centre for further questions." for key "errors[0].description"

    Examples:
      | emailValue                    |
      | onb_email_captured@hymnai.com |
      | onb_happy_path_5@hymnai.com   |
      | onb_happy_path_4@hymnai.com   |


  ## Onboarding Status: EMAIL_CAPTURED, EMAIL_VERIFIED, NAME_DOB_CAPTURED, TELEPHONE_CAPTURED
  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email By Agent - Onboarding Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | email | wrongStatus@hymnai.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | c0ad2bc9-bc94-4c1d-b5bb-90dbaf5bf683 |
      | 93daeaae-b6e6-4430-91fe-c6c272c6589f |
      | 8a307f49-7a77-47d2-9644-e941dd666428 |
      | 62313675-b176-4afb-9395-a3dbccce5658 |


  ## Customer Status: FRAUD, DELETED, SUSPEND
  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email By Agent - Customer Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | email | wrongStatus@hymnai.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 400
    And response body should contain value of "65014" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | dd750b32-e1f2-48e5-89c7-35bfbfad4c55 |
      | 4ce270ac-7018-496c-b0aa-75f76d8036a1 |
      | a2ade24b-eafe-4c1b-b64a-28b906b877b1 |


  @ccEditEmail
  Scenario: CC Edit Email By Agent - Onboarding Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "03144623-29e1-491e-bc0b-a124fc4ea1db"
    And I set request body with information given in the following table
      | email | new_email_address@hymnai.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 204


  # new_email_address@hymnai.com is already requested by another customer
  # Its status is pending email
  @ccEditEmailStatus409
  Scenario: CC Edit Email By Agent - New Email is requested by another customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "e8567aaf-be10-4f45-8b5a-ac880d9c9576"
    And I set request body with information given in the following table
      | email | new_email_address@hymnai.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 409
    And response body should contain value of "65016" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same email. Please call Contact Centre for further questions." for key "errors[0].description"


  ## After running this code for Customer: huyton03@yopmail.com
    # SMS will be sent to customer's phone number
    # Notification Email will be sent to customer's old email address
    # Verification link will be sent to customer's new email address
    # New email address will be stored in pending_email column
    # Customer status or Onboarding status will not be changed
  @ccEditEmailHappyPath
  Scenario: CC Edit Email - Onboarding Customer - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "965b8653-74d5-4647-bcb5-6c1695a12525"
    And I set request body with information given in the following table
      | email | huyton07@yopmail.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 204

  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2YTVhZjI3Yy00ODJjLTQwZWQtOTdhNS0yNmQyODY5NDAyMmQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5NjViODY1My03NGQ1LTQ2NDctYmNiNS02YzE2OTVhMTI1MjUiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU5ODYxNDgwMSwiZXhwIjoxNTk4NzAxMjAxfQ.DK1dLCCqfUsYrBzDnJJgTq8ZiIxBCETDcq6SGZfYvWB78Yd1wU7E4KoiP3hSQ_8AYXWZ1yvbFLeTYZDgS6ojZw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "huyton07@yopmail.com",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "customerStatus": "ACTIVE"
    }
    """





  @ccEditEmailHappyPath
  Scenario: CC Edit Email - Active Customer - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjM2Y2N2VkNy0yYjY0LTQ1ZTQtODBlZS1mYTJiMWQ3MjFkOGMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg2MTA3MjMsImV4cCI6MTU5OTIxNTUyM30.PVwCmJ7af9eCCCkQ2YdpFd7Bc44-EmRKKuvV8doog5DkrndglCP1DKQKzWLIDWIXFrBSt1mavFSTBKJwurc_LA"
    And I set header "customerKey" parameter with value "1d078f53-6339-4a22-898a-cb83caedf33e"
    And I set request body with information given in the following table
      | email | berlin1956@yopmail.com |
    When I PUT request to "/v1/customers/email/agent"
    Then response status code should be 204

  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwMDAzNGJmNy0zZmNkLTRhYTQtODBiOS02ZTJmYTQ1ODE2NzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5NjViODY1My03NGQ1LTQ2NDctYmNiNS02YzE2OTVhMTI1MjUiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU5ODYxMzU4OSwiZXhwIjoxNTk4Njk5OTg5fQ.4pJ_OWkJPZ7s9NcTk5kxlbYySpReu2rx5OpdmQjgeqbXrh3gSksuaEzABbhMsQpG6MIhmvfo0ifM96ks4hPWIA"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "berlin1956@yopmail.com",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "customerStatus": "ACTIVE"
    }
    """




