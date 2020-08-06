Feature: Contact Center - Edit Customer's Email

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @ccUpdateEmailStatus401
  Scenario Outline: CC Edit Email - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | email | TomHanks123@yopmail.com|
    When I PUT request to "/v1/customers/email"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @ccUpdateEmailStatus400
  Scenario Outline: CC Update Email - Email Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YTg3NzYwYi1iMjAwLTQ1MGQtOWVkYy01YzkyNjhjYWI2ZGIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyOWNjMjg4YS0yM2Y0LTQxNjctOTdlZS1jZDU1MDllYjU4MzQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NDY3MDU3LCJleHAiOjE1OTcwNzE4NTd9.jI-NG-in7rI6dy214cbmpSnrKt_PpOcxG2BsRPPHSc791SXDeHToeKtyXTTeTbqPvxubVBjm69Vk_Biy1y3pxA"
    And I set request body with information given in the following table
      | email | <emailValue> |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address|
      |                                                     | email     | size must be between 6 and 50 |
      | a@b.c                                               | email     | size must be between 6 and 50      |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50     |

    # Customer: TomHanks1972@yopmail.comm
  # Try to change the email address as 'TomHanks1972@yopmail.com' which are already existed
  # When customer tries to update their email address with the same one, we return the same error

  @ccUpdateEmailStatus409
  Scenario: CC Update Email - Email already exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkZGVmOGYzOS03NTE2LTQ2NjktOGU5MC0yZDYxMmZkMzQwMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyOWNjMjg4YS0yM2Y0LTQxNjctOTdlZS1jZDU1MDllYjU4MzQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NDc1ODU3LCJleHAiOjE1OTcwODA2NTd9.Cus1gz1sozInnV-CaVsFeVdc9rjlO_-OUDastDuiDaVr2bL9rt1Ej5QjbmdZMfhq9lOAaC-RipiDVYDdJmQG5Q"
    And I set request body with information given in the following table
      | email |vrnrk99@yopmail.com|
    When I PUT request to "/v1/customers/email"
    Then response status code should be 409
    And response body should contain value of "65016" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same email. Please call Contact Centre for further questions." for key "errors[0].description"



     ## After running this code for Customer: TomHanks1972@yopmail.com
    # SMS will be sent to customer's phone number
    # Notification Email will be sent to customer's old email address
    # Verification link will be sent to customer's new email address
    # New email address will be stored in pending_email column
    # Customer status or Onboarding status will not be changed
  @ccUpdateEmail
  Scenario: CC Update Email - Onboarding Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkZGVmOGYzOS03NTE2LTQ2NjktOGU5MC0yZDYxMmZkMzQwMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyOWNjMjg4YS0yM2Y0LTQxNjctOTdlZS1jZDU1MDllYjU4MzQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NDc1ODU3LCJleHAiOjE1OTcwODA2NTd9.Cus1gz1sozInnV-CaVsFeVdc9rjlO_-OUDastDuiDaVr2bL9rt1Ej5QjbmdZMfhq9lOAaC-RipiDVYDdJmQG5Q"
    And I set request body with information given in the following table
      | email | TomHanks1974@yopmail.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 204

   @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
     And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2NjJhYjlmOC1hNWEyLTQ4MjUtOTExMi1hNGViZmRhNjk0YWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyOWNjMjg4YS0yM2Y0LTQxNjctOTdlZS1jZDU1MDllYjU4MzQiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU5NjQ3NTk4NywiZXhwIjoxNTk2NTYyMzg3fQ.oylAmK8ZdDLkTphEhrKiAl82ZJslB53o_P00pT41XVwaLDmlY_iKJ0Rjkksadod0dghygtI1be7JjDx4yF31lA"
     When I POST request to "/v1/customers/verify"
     Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "TomHanks1974@yopmail.com",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "customerStatus": "ACTIVE"
    }
    """


