Feature: CM - Update Name Surname for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @updateNameSurnameStatus401
  Scenario Outline: Update Name Surname - Access token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asr                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |

  @updateNameSurnameStatus400
  Scenario Outline: Update Name Surname - Given names Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkMDY2ODQ2Yy0yYjM0LTRhY2YtOTMyOC0zN2RlZmY4ZjhkMGIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk1NTg2OTc2LCJleHAiOjE1OTYxOTE3NzZ9.jTld1W2qj2WadLILMRFfsCFpZqXBlDPgF8BwwrqcqdjR4BAI2y1QWVBbmXfdWOYlospfZyhCYSZVVXG63iDk_A"
    And I set request body with information given in the following table
      | givenNames  | <givenNamesValue> |
      | surname     | Doe               |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | givenNamesValue                                    | fieldName   | message                       |
      | fsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkha|  givenNames | size must be between 2 and 50 |
      | f                                                  |  givenNames | size must be between 2 and 50 |
      |                                                    |  givenNames | size must be between 2 and 50 |

  @updateNameSurnameStatus400
  Scenario Outline: Update Name Surname- Surname Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkMDY2ODQ2Yy0yYjM0LTRhY2YtOTMyOC0zN2RlZmY4ZjhkMGIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk1NTg2OTc2LCJleHAiOjE1OTYxOTE3NzZ9.jTld1W2qj2WadLILMRFfsCFpZqXBlDPgF8BwwrqcqdjR4BAI2y1QWVBbmXfdWOYlospfZyhCYSZVVXG63iDk_A"
    And I set request body with information given in the following table
      | givenNames  | John          |
      | surname     | <surnameValue>|
    When I PUT request to "/v1/customers/name"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | surnameValue                                       | fieldName   | message                       |
      | fsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkha| surname     | size must be between 2 and 50 |
      | f                                                  | surname     | size must be between 2 and 50 |
      |                                                    | surname     | size must be between 2 and 50 |

  @updateNameSurnameStatus200
  Scenario: Update Name Surname - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkYTMzYTM1ZC0xMmI0LTQ2ZGMtOGMyYy1mOGI5NjAyZWMzNTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyNWM1MDI1YS00NGMzLTQ0N2MtYmNlNy1lN2U5MjIwM2UzNjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk1NTg3NDY0LCJleHAiOjE1OTYxOTIyNjR9.QlqfVsA7bCCncozk7ZprwfWMJPX_L3xA_Uai8Bsp0lHv7VNCbdlUzMtlid-6_UDkFplUUhnSob7JRFIAewbFpQ"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 204

  @updateNameSurnameStatus401
  Scenario: Update Name Surname - Expired Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkNzk0ZTFmYS01NWIzLTRiZTItYjkwZS1iZWRkOGM1YzRlNGEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkxMzcwODMzLCJleHAiOjE1OTE5NzU2MzN9.o1ZxID33NXiYZiUgTixb4KNxUwPmlmfgwEcN_KRtdOhQO98XQP9QXLOlKE4m89TjJJs-yhqHw2HUU5rdFhGokQ"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

  @updateNameSurnameStatus403
  Scenario: Update Name Surname - Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhN2MxNzkyMS1iNDdlLTRiNjYtODBjOS1iNjQ3ZDYxNzFiMWUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhZ2VudDIzIiwic2NvcGUiOiJBR0VOVCIsImlhdCI6MTU5NTU4NjY2NCwiZXhwIjoxNTk2MTkxNDY0fQ.gyC-X7GdwvENnetTFs5pta5k-uaCeypBh-OzHvC08T-Cp0FDeLT0oGTlX15g5T9HNjmWYCfs2RifXpundcSEDQ"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
