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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwYTI2YjQ3ZS01M2VkLTRkNjgtYjNmZi1jYTE3MGJjZDdlZWQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MjE3ODMxLCJleHAiOjE1OTQ4MjI2MzF9.7yd5LMf9rfqC_GxTiEQ45YOSgaa7XMo8ptosDPJbs58bOhdRa9UITfOdi8QzV9f2_qSqfoKeNbD-DZC3ZGZCzw"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwYTI2YjQ3ZS01M2VkLTRkNjgtYjNmZi1jYTE3MGJjZDdlZWQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MjE3ODMxLCJleHAiOjE1OTQ4MjI2MzF9.7yd5LMf9rfqC_GxTiEQ45YOSgaa7XMo8ptosDPJbs58bOhdRa9UITfOdi8QzV9f2_qSqfoKeNbD-DZC3ZGZCzw"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwYTI2YjQ3ZS01M2VkLTRkNjgtYjNmZi1jYTE3MGJjZDdlZWQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MjE3ODMxLCJleHAiOjE1OTQ4MjI2MzF9.7yd5LMf9rfqC_GxTiEQ45YOSgaa7XMo8ptosDPJbs58bOhdRa9UITfOdi8QzV9f2_qSqfoKeNbD-DZC3ZGZCzw"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0OTQzZWYwYi0zMDZlLTRiMGUtODE1Zi01MzRmZDY1MmRiZTYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZW1vYWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkzNTQyNzM0LCJleHAiOjE1OTQxNDc1MzR9.-Nc3mRsQwJXTgEjCZI5W5RB5mRurlovdE9nU9XOlwWONf3pXr5SfervAV0h5GlUY-nsMtLr4ZrnVkS-SN2RxTA"
    And I set request body with information given in the following table
      | givenNames  | John       |
      | surname     | Doe        |
    When I PUT request to "/v1/customers/name"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
