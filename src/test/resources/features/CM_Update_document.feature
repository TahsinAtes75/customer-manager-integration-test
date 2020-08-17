Feature: Customer Manager - Document Service Update Document

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @updateDocumentStatus401
  Scenario Outline: Update Document - Access token validation
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asr                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @updateDocumentStatus400
  Scenario Outline: Update Document - Document key validation
    And I set header "key" parameter with value "<documentKeyValue>"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"
    And response body should contain value of "key" for key "errors[0].field"

    Examples:
      | documentKeyValue                      | message           |
      | asr                                   | length must be 36 |
      | sdfsdfsdf_sdfsdfsd_asfdsadfsda_sdfsdf | length must be 36 |

  @updateDocumentStatus400
  Scenario: Update Document - Empty document key validation
    And I set header "key" parameter with value ""
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 400

  @updateDocumentStatus400
  Scenario Outline: Update Document - Status Validation Test
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | <statusValue>     |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 400

    Examples:
      | statusValue |
      |             |
      | dfsdfsdfsf  |
      | IN_PROGRESS |
      | CLEAR       |
      | CONSIDER    |
      | REJECTED    |

  #The status should be  none, in_progress, clear, consider and rejected

  @updateDocumentStatus400
  Scenario Outline: Update Document - SubType Validation Test
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | <subTypeValue>    |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 400

    Examples:
      | subTypeValue    |
      |                 |
      | dfsdfsdfsf      |
      | driving licence |
      | ID card         |
      | UNKNOWN         |

  #The status should be  passport, driving_licence, national_identity_card, voter_id, work_permit, bank_building_society_statement, utility_bill, council_tax, benefit_letters, marriage_certificate, divorce_certificate, deed_pool, photo, watchlist, unknown


  @updateDocumentStatus200
  Scenario: Update Document - Happy Path
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 200

  @updateDocumentStatus404
  Scenario: Update Document - documentKey Not Found
    And I set header "key" parameter with value "53480ee6-09c6-4bfe-bc6c-9125d9f8669G"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjE2MjFhNi1iMmQxLTQ2MjItYjg2NC1iMjE2MmRiZmFiNzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTc0MTIwMjAsImV4cCI6MTU5ODAxNjgyMH0.gAVRtWR1HEv5akBVt577RQWeFLydJzffHNmCINxDovUer7hTQKriH0NuJDc7a-trdZ-4VKk_vdGRsORTdzrCGA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 404
    And response body should contain value of "65223" for key "errors[0].code"
    And response body should contain value of "Document not found with key : 53480ee6-09c6-4bfe-bc6c-9125d9f8669G." for key "errors[0].description"

  @updateDocumentStatus401
  Scenario: Update Document - Expired Agent Access Token
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmYTk2YWI5Ni01MDZmLTQzNmItYWQ4NS0xM2Q1YjRhZWYwNWQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY0NzIyNjksImV4cCI6MTU5NzA3NzA2OX0.Ms_Vo5XtqAo3Wg41SDEaxngtKr3nelWlrU7pFJLfEG4yRJAr139W-Fmcf4KStG8bVnt-bOQdXnC-NAqnGJhUKg"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

  @updateDocumentStatus403
  Scenario: Update Document - Customer Access Token
    And I set header "key" parameter with value "052d63c0-7af3-4f3b-939c-1dfd957c763d"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxZjRjOGE0MS1mYjRkLTQ0YzAtOTA2MS00OTJhOGUyM2M2ZDYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5MzBhMDkyYy1kNGZiLTRhMTktOGY1NS1lNDg5ZWY0NDJiOTkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk3NjY0MTc2LCJleHAiOjE1OTgyNjg5NzZ9.JD3GIcMCgcsHaRndtQVLbHszZzMIbORja20Ud-03mujP-KoGWizfakD1jTzI_xkMcc7og41VK7cdSZYTdSLdfA"
    And I set request body with information given in the following table
      | authorityId    | 123456789         |
      | decisionReason | ID verified       |
      | issuedAt       | 2020-08-14        |
      | properties     |                   |
      | status         | clear             |
      | subType        | passport          |
      | title          | ID Document       |
    When I PUT request to "/v1/documents"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
