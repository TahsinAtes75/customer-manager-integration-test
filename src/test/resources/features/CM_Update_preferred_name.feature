Feature: CM - Update Preferred name for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @updatePreferredNameStatus401
  Scenario Outline: Update Preferred Name - Access token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
      |preferredName| Johny      |
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
  Scenario Outline: Update Preferred Name - Given names Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmNzRjODhlYy1iMWRlLTQxNzMtOWE5ZS0wZDM4MDJhY2RhMTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI2M2EzN2E4Mi1lNGYwLTQ0ODEtYTYyNC0zNjg5NjBmM2VhNGMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NzA4MDczLCJleHAiOjE1OTczMTI4NzN9.OPQ9z5Rd68_zk7UaW4Zn4aLGt2XobExSvMmJvGCJpBFcBc4AUooecqN5lalBPWLifBFKbFABTsoVGoUVnl9GBA"
    And I set request body with information given in the following table
      | givenNames  | <givenNamesValue> |
      | surname     | Doe               |
      |preferredName| Johny             |
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
  Scenario Outline: Update Preferred Name- Surname Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmNzRjODhlYy1iMWRlLTQxNzMtOWE5ZS0wZDM4MDJhY2RhMTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI2M2EzN2E4Mi1lNGYwLTQ0ODEtYTYyNC0zNjg5NjBmM2VhNGMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NzA4MDczLCJleHAiOjE1OTczMTI4NzN9.OPQ9z5Rd68_zk7UaW4Zn4aLGt2XobExSvMmJvGCJpBFcBc4AUooecqN5lalBPWLifBFKbFABTsoVGoUVnl9GBA"
    And I set request body with information given in the following table
      | givenNames  | John          |
      | surname     | <surnameValue>|
      |preferredName| Johny      |
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
  @updatePreferredNameStatus400
  Scenario Outline: Update Preferred Name- Preferred Name Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmNzRjODhlYy1iMWRlLTQxNzMtOWE5ZS0wZDM4MDJhY2RhMTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI2M2EzN2E4Mi1lNGYwLTQ0ODEtYTYyNC0zNjg5NjBmM2VhNGMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NzA4MDczLCJleHAiOjE1OTczMTI4NzN9.OPQ9z5Rd68_zk7UaW4Zn4aLGt2XobExSvMmJvGCJpBFcBc4AUooecqN5lalBPWLifBFKbFABTsoVGoUVnl9GBA"
    And I set request body with information given in the following table
      | givenNames  | John          |
      | surname     | wilmorth|
      |preferredName| <preferredNameValue>     |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | preferredNameValue                                  |fieldName         | message                       |
      | fsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkhfsfkhsjfkha| preferredName     | size must be between 2 and 50 |
      | f                                                  | preferredName    | size must be between 2 and 50 |
      |                                                    | preferredName    | size must be between 2 and 50 |

  @updatePreferredNameStatus204
  Scenario: Update Name Surname - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmNzRjODhlYy1iMWRlLTQxNzMtOWE5ZS0wZDM4MDJhY2RhMTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI2M2EzN2E4Mi1lNGYwLTQ0ODEtYTYyNC0zNjg5NjBmM2VhNGMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk2NzA4MDczLCJleHAiOjE1OTczMTI4NzN9.OPQ9z5Rd68_zk7UaW4Zn4aLGt2XobExSvMmJvGCJpBFcBc4AUooecqN5lalBPWLifBFKbFABTsoVGoUVnl9GBA"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
      |preferredName| Johny      |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 204

  @updatePreferredNameStatus401
  Scenario: Update Preferred Name - Expired Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkNzk0ZTFmYS01NWIzLTRiZTItYjkwZS1iZWRkOGM1YzRlNGEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkxMzcwODMzLCJleHAiOjE1OTE5NzU2MzN9.o1ZxID33NXiYZiUgTixb4KNxUwPmlmfgwEcN_KRtdOhQO98XQP9QXLOlKE4m89TjJJs-yhqHw2HUU5rdFhGokQ"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
      |preferredName| Johny      |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

  @updatePreferredNameStatus403
  Scenario: Update Preferred Name - Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3OGUzOTllYS1lYjc0LTQyM2YtODBiZS0xMDgwMmYyZjBjZDkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTY3MDg3ODUsImV4cCI6MTU5NzMxMzU4NX0.ETYmy-72DzUR7SUbThjoyW4b4AUp7Aof4jPFxXcUYB9udzzWiScKt3OneUp8y_7FzHjnGwqdfF67Sz6Jg4J4pA"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
      |preferredName| Johny      |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
