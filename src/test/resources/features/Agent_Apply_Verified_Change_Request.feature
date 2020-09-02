Feature: Customer Manager - Agent apply verified change request

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @putChangeRequestByKey
  Scenario: Agent apply verified change request - HappyPath
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "dc2c87f0-ea47-41ee-a36b-93fc56de2743"
    When I PUT request to "/v1/change-request/reapply"
    Then response status code should be 204

  @putChangeRequestByKey
  Scenario: Agent apply verified change request - HappyPath-1
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "a682eebd-0151-49a3-afbd-4cc7be76ed97"
    When I PUT request to "/v1/change-request/reapply"
    Then response status code should be 204


  @putChangeRequestStatus403
  Scenario Outline: Put Change Request By Key - Token Validation with customer token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "dc2c87f0-ea47-41ee-a36b-93fc56de2743"
    When I PUT request to "/v1/change-request/reapply"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhNGE4YTlhZC02OWIxLTQ1ODAtODkzYy05NDYzOTExYWI3ZWIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5NjViODY1My03NGQ1LTQ2NDctYmNiNS02YzE2OTVhMTI1MjUiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk5MDMyMzc4LCJleHAiOjE1OTk2MzcxNzh9._SSPB0uqUyV-bxE0zulqW-ShqONTVVlp8MGS3mI_7ivuDGDROu7cy5zpFFnH3keMaTI44jEJHocJ-K87mm9hJg |



  @putChangeRequestStatus401
  Scenario Outline: Put Change Request By Key - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "dc2c87f0-ea47-41ee-a36b-93fc56de2743"
    When I PUT request to "/v1/change-request/reapply"
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
  @putChangeRequestStatus400
  Scenario Outline: Put Change Request By Key - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "<keyValue>"
    When I PUT request to "/v1/change-request/reapply"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "changeRequestKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @putChangeRequestStatus404
  Scenario Outline: Put Change Request By Key - Task Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMDkzYjMxYi00MjU5LTQyZjUtYmE1OS0yNDFkMDBkMmRlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTg5NDkyOTMsImV4cCI6MTU5OTU1NDA5M30.ph40GKfgLxwuxiowEllu6WCX6SAv3BKDCEPTfmzmzpow4jY2XWiSoYDNqI9l9dAgYGuwo-YK0sQdMyLqX6ngRA"
    And I set header "changeRequestKey" parameter with value "<keyValue>"
    When I PUT request to "/v1/change-request/reapply"
    Then response status code should be 404
    And response body should contain value of "65036" for key "errors[0].code"
    And response body should contain value of "Change request not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |
      | cd125297-7560-4a6d-9a09-d8084ef3b6f0 |

    ##
  #Last validation for when we call the api with "deleted task key"
   ##