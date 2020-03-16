Feature: Customer Onboarding - Verify Email Notification Token

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @verifyEmailStatus401
  Scenario Outline: Verify Email - Verification Token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |



  #### Verification token for customer: v_token_expired@hymnai.com
  #### Expiry date: 2020-02-05 11:12:14
  @verifyEmailStatus401
  Scenario: Verify Email - Access token is expired
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiOGE4MzQ3OC03MjY3LTQ1NGYtYmI5Mi04NDZiZmEzNjJlMmMiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDkwMTEwNCwiZXhwIjoxNTgwOTAxMTM0fQ.V2FOAk8Eb5T669_RpjRzZCeXDOeGN3JpoETNErNcR6LjZGAnGDrfwpDB2Wkv3iTuPnXX6bQQhCOTGdejeNxP3g"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"



  # Customer's status is ADDRESS_CAPTURED
  # Customer: onb_address_captured@hymnai.com
  @verifyEmailStatus400
  Scenario: Verify Email - Status is incompatible
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJlODU2N2FhZi1iZTEwLTRmNDUtOGI1YS1hYzg4MGQ5Yzk1NzYiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MzgzNDc2NCwiZXhwIjoxODk2NTIwMzM0fQ.UEiqTrRtc4aza7soagRHv2rGBx7GBrFek93F_G981getKDSjD3ryF4hesdwdMP9I_Q4VdmL8tAQg_04-c4G_eA"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 400
    And response body should contain value of "65019" for key "errors[0].code"
    And response body should contain value of "Email is already verified" for key "errors[0].description"


