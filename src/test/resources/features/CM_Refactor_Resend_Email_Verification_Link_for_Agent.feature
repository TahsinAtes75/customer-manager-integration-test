Feature: Customer Manager - Onboarding Service Re-Send Email Verification Link for Agent

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @cmResendVerificationLinkForAgentStatus401
  Scenario Outline:Resend verification link - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "eff33c3a-bc5a-4163-b3b7-e9310e1d9636"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @cmResendVerificationLinkForAgentStatus401
  Scenario: Resend verification link - Expired Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYmIzNzhhNi0zNTgxLTRjZjEtOWFiZS0yMzA2MGJjZDBlMzAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ1c2VydXNlciIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTE4OTY2NjIsImV4cCI6MTU5MjUwMTQ2Mn0.r1cejaNx5uu5qT3-gPae0OO-bLVtYorfCy5GW7OZ7X_Vd1jNsvx7MZe8H4BOfzqhd5HuC_ryK3uMrB20C5VSJg"
    And I set header "key" parameter with value "eff33c3a-bc5a-4163-b3b7-e9310e1d9636"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"



  @cmResendVerificationLinkForAgentStatus403
  Scenario: Resend verification link - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YmJhYWZiMS1jY2FhLTQ2N2YtODY0Mi0xZmFjZGJiODhkMjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlZmYzM2MzYS1iYzVhLTQxNjMtYjNiNy1lOTMxMGUxZDk2MzYiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2ODA3ODM0LCJleHAiOjE1OTc0MTI2MzR9.Uv0j_Wr0oNWdIlJekJs64ppAjHqjuw7BcJUXvWXtEew8trHOPIA7i3ApmRwpLEvpbMDkOJvhVSuYw-uGrKMeMw"
    And I set header "key" parameter with value "eff33c3a-bc5a-4163-b3b7-e9310e1d9636"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @cmResendVerificationLinkForAgentStatus400
  Scenario Outline: Resend verification link - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlMjAwMGM3NS03NzI4LTQxYzAtOTRlYy1hZDhkNWE3ZTdlZDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY4MDc5ODEsImV4cCI6MTU5NzQxMjc4MX0.3nmNIhmnCy9jeeC3ODZzI5c8M39yGEK2KzNKfflR4eh1yRqdI2AcI2q3EuiOGiHkV7TKgjnLOhLpHDl515J_Vw"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @cmResendVerificationLinkForAgentStatus404
  Scenario Outline: Resend verification link - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlMjAwMGM3NS03NzI4LTQxYzAtOTRlYy1hZDhkNWE3ZTdlZDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY4MDc5ODEsImV4cCI6MTU5NzQxMjc4MX0.3nmNIhmnCy9jeeC3ODZzI5c8M39yGEK2KzNKfflR4eh1yRqdI2AcI2q3EuiOGiHkV7TKgjnLOhLpHDl515J_Vw"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  # Customer1: ttrr@yopmail.com (ADDRESS_CAPTURED)
  # Customer2: johnlee10@yopmail.com (NAME_DOB_CAPTURED)
  @cmResendVerificationLinkForAgentStatus400
  Scenario Outline: Resend verification link - Incompatible Status
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlMjAwMGM3NS03NzI4LTQxYzAtOTRlYy1hZDhkNWE3ZTdlZDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY4MDc5ODEsImV4cCI6MTU5NzQxMjc4MX0.3nmNIhmnCy9jeeC3ODZzI5c8M39yGEK2KzNKfflR4eh1yRqdI2AcI2q3EuiOGiHkV7TKgjnLOhLpHDl515J_Vw"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | 7f301e40-1fc2-437c-a99d-00590911076b |
      | 97d50549-663f-4778-8894-ba29f0a29e6d |


  # Customer: newonbr44@yopmail.com
  @@cmResendVerificationLinkForAgent
  Scenario: Resend verification link - Happy Path - EMAIL_CAPTURED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlMjAwMGM3NS03NzI4LTQxYzAtOTRlYy1hZDhkNWE3ZTdlZDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY4MDc5ODEsImV4cCI6MTU5NzQxMjc4MX0.3nmNIhmnCy9jeeC3ODZzI5c8M39yGEK2KzNKfflR4eh1yRqdI2AcI2q3EuiOGiHkV7TKgjnLOhLpHDl515J_Vw"
    And I set header "key" parameter with value "eff33c3a-bc5a-4163-b3b7-e9310e1d9636"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 204



  # Customer: newonbr45@yopmail.com
  # Manually set onboarding status as EMAIL_VERIFIED
  # After it runs check DB, onboarding status must be EMAIL_CAPTURED, email_verified field must be set from 1 to 0
  @cmResendVerificationLinkForAgentStatus
  Scenario: Resend verification link - Happy Path - EMAIL_VERIFIED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlMjAwMGM3NS03NzI4LTQxYzAtOTRlYy1hZDhkNWE3ZTdlZDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY4MDc5ODEsImV4cCI6MTU5NzQxMjc4MX0.3nmNIhmnCy9jeeC3ODZzI5c8M39yGEK2KzNKfflR4eh1yRqdI2AcI2q3EuiOGiHkV7TKgjnLOhLpHDl515J_Vw"
    And I set header "key" parameter with value "84d41043-7c2e-4610-a50e-e5e165c77904"
    When I GET request to "/v1/customers/resend-link/agent"
    Then response status code should be 204



  ######
  # After resending verification link to the customer, its onboarding status becomes EMAIL_CAPTURED.
  # To make customer's onboarding status EMAIL_VERIFIED again, run the code below
  ######
  @verifyEmail
  Scenario: Verify Email - newonbr45@yopmail.com
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YjE4OWQzNy1hZjQ2LTQ1ZWYtOWI3YS05NDE2MjQ5ZWZkZjUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NGQ0MTA0My03YzJlLTQ2MTAtYTUwZS1lNWUxNjVjNzc5MDQiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU5NjgxNDA2NCwiZXhwIjoxNTk2OTAwNDY0fQ.PqyX6eRE6skZeHVuhc1C7gthA3xCWqSwJbOw56BNyEv_VgpgeS3R8esTLokjOsTnqXsOwSWkhdJEu7DOR24R-Q"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
