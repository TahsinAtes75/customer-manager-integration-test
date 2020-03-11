Feature: Contact Center - Onboarding Support Re-Send Verification Link

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @ccResendVerificationLinkStatus401
  Scenario Outline: Resend verification link - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @ccResendVerificationLinkStatus401
  Scenario: Resend verification link - Expired Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set header "key" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"



  @ccResendVerificationLinkStatus403
  Scenario: Resend verification link - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "key" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @ccResendVerificationLinkStatus400
  Scenario Outline: Resend verification link - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @ccResendVerificationLinkStatus404
  Scenario Outline: Resend verification link - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  # Customer1: onb_address_captured@hymnai.com (ADDRESS_CAPTURED)
  # Customer2: onb_name_DoB@hymnai.com (NAME_DOB_CAPTURED)
  @ccResendVerificationLinkStatus400
  Scenario Outline: Resend verification link - Incompatible Status
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "<keyValue>"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | e8567aaf-be10-4f45-8b5a-ac880d9c9576 |
      | 8a307f49-7a77-47d2-9644-e941dd666428 |


  # Customer: onb_email_captured@hymnai.com
  @ccResendVerificationLink
  Scenario: Resend verification link - Happy Path - EMAIL_CAPTURED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "c0ad2bc9-bc94-4c1d-b5bb-90dbaf5bf683"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 204



  # Customer: onb_email_verified@hymnai.com
  # Manually set onboarding status as EMAIL_VERIFIED
  # After it runs check DB, onboarding status must be EMAIL_CAPTURED, email_verified field must be set from 1 to 0
  @ccResendVerificationLink
  Scenario: Resend verification link - Happy Path - EMAIL_VERIFIED
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "key" parameter with value "93daeaae-b6e6-4430-91fe-c6c272c6589f"
    When I GET request to "/v1/customers/resend-link"
    Then response status code should be 204



  ######
  # After resending verification link to the customer, its onboarding status becomes EMAIL_CAPTURED.
  # To make customer's onboarding status EMAIL_VERIFIED again, run the code below
  ######
  @verifyEmail
  Scenario: Verify Email - onb_email_verified@hymnai.com
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5M2RhZWFhZS1iNmU2LTQ0MzAtOTFmZS1jNmMyNzJjNjU4OWYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzkyMjAxMywiZXhwIjoxNTg0MDA4NDEzfQ.7C9sRHAi7ibd1toOQHeSapl_Y2PcgA7s9B0jJ3qE5z7beTSsAYRCDcdUams3K0RMRCbVvHzFNU_lrL71qX_6zw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
