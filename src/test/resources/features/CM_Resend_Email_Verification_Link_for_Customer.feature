Feature: Customer Manager - Onboarding Service Re-Send Email Verification Link for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @cmResendVerificationLinkForCustomerStatus401
  Scenario Outline: Resend verification link - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @cmResendVerificationLinkForCustomerStatus401
  Scenario: Resend verification link - Expired Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkMWJlZDc1OS0wZWQ1LTQ2YzgtODRhYS0zZmI5MDFkNmQ0OWYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MzA5MDcwLCJleHAiOjE1OTQ5MTM4NzB9.h0fFB8ETvsH6qQbROUnAwUJ79dmVfpyApJ1jQ0R4Ts92vbqoiky0cOasBt3-OO56w2GizQTtYLDXjr6AYNwUnQ"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"



  @cmResendVerificationLinkForCustomerStatus403
  Scenario: Resend verification link - Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmYTk2YWI5Ni01MDZmLTQzNmItYWQ4NS0xM2Q1YjRhZWYwNWQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY0NzIyNjksImV4cCI6MTU5NzA3NzA2OX0.Ms_Vo5XtqAo3Wg41SDEaxngtKr3nelWlrU7pFJLfEG4yRJAr139W-Fmcf4KStG8bVnt-bOQdXnC-NAqnGJhUKg"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  # Customer: update3@yopmail.com (Customer Status=ACTIVE)
  @cmResendVerificationLinkForCustomerStatus400
  Scenario: Resend verification link - Incompatible Status
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiNzU3ZmY2OS00NmJjLTRjNjQtYjE1Ny04YzEzNjNkYzhjMjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2Nzk3NDE2LCJleHAiOjE1OTc0MDIyMTZ9.0gzZHOCCR9den_BQAbPNCkX8PY6Vh8fF4oqzfYtMkyLwhjgB41C_gGRa86m6_bLiSzTH7HYrJvzZ2nYp7mT1GQ"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 400
    And response body should contain value of "65014" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"



  # Customer: newonbr43@yopmail.com
  @ccResendVerificationLink
  Scenario: Resend verification link - Happy Path - EMAIL_CAPTURED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5YzgzMGYxZS04MzE1LTRjYzUtOTVhMS0zZDYyM2RkMTI0YjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0NjFkYzJmNy1iY2ZjLTQxYWQtYjc1Ny0zNjg3NjY0NTRkZWMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2ODAzMDYyLCJleHAiOjE1OTc0MDc4NjJ9.WPEN6hW1BhyjweaKwB_Ouo_TFtShvzRwphB9-wBeV7qP_e9uO9ZwSoKedFMGrVaqN2afJBwfMksHJS1sPYIrVQ"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 204



  # Customer: newonbr43@yopmail.com
  # Manually set onboarding status as EMAIL_VERIFIED
  # After it runs check DB, onboarding status must be EMAIL_CAPTURED, email_verified field must be set from 1 to 0
  @ccResendVerificationLink
  Scenario: Resend verification link - Happy Path - EMAIL_VERIFIED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5YzgzMGYxZS04MzE1LTRjYzUtOTVhMS0zZDYyM2RkMTI0YjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI0NjFkYzJmNy1iY2ZjLTQxYWQtYjc1Ny0zNjg3NjY0NTRkZWMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2ODAzMDYyLCJleHAiOjE1OTc0MDc4NjJ9.WPEN6hW1BhyjweaKwB_Ouo_TFtShvzRwphB9-wBeV7qP_e9uO9ZwSoKedFMGrVaqN2afJBwfMksHJS1sPYIrVQ"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 204


