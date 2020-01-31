Feature: Customer Onboarding - Verify Email Notification Token

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"

  @verifyEmailStatus401
  Scenario Outline: Verify Email - Verification Token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
    | tokenValue  |
    |             |
    | asd         |
    | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
    | eyJhbGciOiJIUzUxMiJ9.1eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |



  #### Verification token for customer: v_token_expired@hymnai.com
  #### Expiry date: 2020-01-28 14:15:17
  @verifyEmailStatus401
  Scenario: Verify Email - Access token is expired
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.Ows9YYLHXKSB2fIYeGC8NO_rqeFzu5bN6JBZgn4NTmcMeYkudtQ4dUk4NBQWIyX2p5aTf_ExhRcuxDyoh3s0nw"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"


  # Customer's status is ADDRESS_CAPTURED
  @verifyEmailStatus400
  Scenario: Verify Email - Status is incompatible
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjZDM5M2IyYS1mMTNmLTRhMGItOWMyNi1hYWFiNzg1N2RiMGIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDE0MzIyOCwiZXhwIjoxODk1OTgyNjQyfQ.bFRWPO11SUdBJ-e_V_DbmbDTMVK8qu59qjiW-OmMtUnLSDMm3z29tm1zkN7305ewDR9U-iLjj_Ki4emU3b6G4g"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 400
    And response body should contain value of "65009" for key "code"
    And response body should contain value of "The customer state is incompatible" for key "message"


