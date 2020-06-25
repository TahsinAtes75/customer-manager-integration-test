Feature: Customer Manager - Update Check Details

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  @updateCheckDetails
  Scenario: Update Check Details - HappyPath
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwNDA1ZWZjMC00NDY2LTQ0MzUtOWE0YS0wMjM5OGI3NmUzZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ0ZXN0YWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkyODE3MTIzLCJleHAiOjE1OTM0MjE5MjN9.L4xzFvqGDpqOKGzBxEEdEFEnyGKhGrCLbm9JPXoU1Hz6XzfGcVC4LFctm01Vg7jAXQ3s3tIkD8odmp-kcwpmwA"
    And I set header "key" parameter with value "6e4655c9-1b91-400d-a8d7-84213d6e95f2"
    And I set request body with information given in the following table
      | decisionReason  | ID verified|
      | status          | clear      |
    When I PUT request to "/v1/checks"
    Then response status code should be 200

  @updateCheckDetails403
  Scenario Outline: Update Check Details - Token Validation with customer token and onboarding token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "c0f3fa37-d50c-4303-bc78-bacb69ceb742"
    And I set request body with information given in the following table
      | decisionReason  | clear    |
      | status          | clear    |
    When I PUT request to "/v1/checks"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5NDIwYTIwOS1lODhkLTRiNjUtYTY0NC1kMWQzNjNjNzU5YTIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTU3NjU5My1mYWEwLTRjNTgtYTI5NS0wZDFiMjY5MDYxMDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg3MDM1NjQ1LCJleHAiOjE5MDI1Njg1MzF9.fjt_6OzKCVGz-IdRqlLezTI47zw1B-lXNSCtpkkkmVSdgRHbR3T1ReC0JZ3HcPGIOMH_CFpLixOGcFUkmSCjjg |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YWIzMDBiYS0yYWM0LTQ4NGItYTQzOS1lNTdjZTRjOWE1ZjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODY5NjgxMjUsImV4cCI6MTkwMjUwMzc4M30.WyPC_RySFaEcHvamDI59vy379WlHz94pHkk5KzzI6XWCiewBENUWnD5TNBZgU2kK_rpB4xjSe0ujy-whfuTb0g |


  @updateCheckDetails401
  Scenario Outline: Update Check Details - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "c0f3fa37-d50c-4303-bc78-bacb69ceb742"
    And I set request body with information given in the following table
      | decisionReason  | clear    |
      | status          | clear    |
    When I PUT request to "/v1/checks"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzZTQ5ZDdhYS1jZjc3LTQ5OWUtODViOS04M2NiYTQxNWJhYjMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4Njk2NzY4NywiZXhwIjoxOTAyNTAyMDkyfQ.fAyZfl_addQq2E0L5POJxUtuNNGMknWklp6J2vquqoJTuMOIxMWOe8lJNecP05imuAb6JwyG8XOn2wwFMo37CA  |

     ##
  #Last validation for when we call the api with "verification token"
   ##
  @updateCheckDetails400
  Scenario Outline: Update Check Details - Invalid Task Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwNDA1ZWZjMC00NDY2LTQ0MzUtOWE0YS0wMjM5OGI3NmUzZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ0ZXN0YWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkyODE3MTIzLCJleHAiOjE1OTM0MjE5MjN9.L4xzFvqGDpqOKGzBxEEdEFEnyGKhGrCLbm9JPXoU1Hz6XzfGcVC4LFctm01Vg7jAXQ3s3tIkD8odmp-kcwpmwA"
    And I set header "key" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | decisionReason  | clear    |
      | status          | clear    |
    When I PUT request to "/v1/checks"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "key" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @updateCheckDetails404
  Scenario Outline: Update Check Details - Task Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwNDA1ZWZjMC00NDY2LTQ0MzUtOWE0YS0wMjM5OGI3NmUzZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ0ZXN0YWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkyODE3MTIzLCJleHAiOjE1OTM0MjE5MjN9.L4xzFvqGDpqOKGzBxEEdEFEnyGKhGrCLbm9JPXoU1Hz6XzfGcVC4LFctm01Vg7jAXQ3s3tIkD8odmp-kcwpmwA"
    And I set header "key" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | decisionReason  | clear   |
      | status          | rejected|
    When I PUT request to "/v1/checks"
    Then response status code should be 404
    And response body should contain value of "65221" for key "errors[0].code"
    And response body should contain value of "Check not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |
      | a19d864a-f4ca-42d0-b7bc-81c4ec275fee |

    ##
  #Last validation for when we call the api with "deleted check key"
   ##

  @updateCheckDetails
  Scenario Outline: Update Check Details - Status Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwNDA1ZWZjMC00NDY2LTQ0MzUtOWE0YS0wMjM5OGI3NmUzZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ0ZXN0YWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkyODE3MTIzLCJleHAiOjE1OTM0MjE5MjN9.L4xzFvqGDpqOKGzBxEEdEFEnyGKhGrCLbm9JPXoU1Hz6XzfGcVC4LFctm01Vg7jAXQ3s3tIkD8odmp-kcwpmwA"
    And I set header "key" parameter with value "c0f3fa37-d50c-4303-bc78-bacb69ceb742"
    And I set request body with information given in the following table
      | decisionReason  | clear      |
      | status          | <statusValue> |
    When I PUT request to "/v1/checks"
    Then response status code should be 400
    And response body should contain value of "65233" for key "errors[0].code"
    And response body should contain value of "Check should be clear or reject" for key "errors[0].description"

    Examples:
      | statusValue |
      | none        |
      | consider    |
