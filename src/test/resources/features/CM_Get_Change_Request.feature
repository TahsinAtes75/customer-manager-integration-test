Feature: Customer Manager - Get Change Request

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getChangeRequestByKey
  Scenario: Get Change Request By Key - HappyPath
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMGNjOWI1NS1iMWEzLTQxODItYWY2Ni05MmNiZjEwNTM2MzQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NTUyNzA0LCJleHAiOjE1OTUxNTc1MDR9.WH2Gr5PfWwHYQ9VC7kA7CMBunDquvxeSfl4v758JrFnaLcPZ8ONgZm09n5QVfSZBBuDvGYj4_Y09gsp1lBj9fg"
    And I set header "changeRequestKey" parameter with value "64695326-b19e-48d6-a2e7-e5292245b8cd"
    When I GET request to "/v1/change-request"
    Then response status code should be 200

  @getChangeRequestStatus403
  Scenario Outline: Get Change Request By Key - Token Validation with agent token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "64695326-b19e-48d6-a2e7-e5292245b8cd"
    When I GET request to "/v1/change-request"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ODU0MTRjYy03OWQzLTQyMjktYWEyZC01N2RmMzQ1YzhiYTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZW1vMiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTQzNzk2MTMsImV4cCI6MTU5NDk4NDQxM30.xESjHkHVMBv_yrx6NdT9rsyv1fg-uSVnqNd1XOyqKBcEr9rJWlGgqPMEjAsBQkTnid2WzyQTS3D4ycy_ts0vuQ |

  @getChangeRequestStatus400
  Scenario Outline: Get Change Request By Key - Token Validation with improper customer token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "64695326-b19e-48d6-a2e7-e5292245b8cd"
    When I GET request to "/v1/change-request"
    Then response status code should be 400
    And response body should contain value of "65037" for key "errors[0].code"
    And response body should contain value of "Change request does not belong to customer" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0NjgxNGFkNy01ZWM5LTQ5ZjAtOTY0My03Yzc3OTA0MjBmY2QiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NTU0MDgwLCJleHAiOjE1OTUxNTg4ODB9.i_U0xvM68iQlWlJ3hxI1b4dgiZD9b4-QZy4W3helZ1_V7NYbc2Ihj9ZkxR-sqla0DtfhhfrHDJYPS-22yLNuzQ |


  @getChangeRequestStatus401
  Scenario Outline: Get Change Request By Key - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "64695326-b19e-48d6-a2e7-e5292245b8cd"
    When I GET request to "/v1/change-request"
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
  @getChangeRequestStatus400
  Scenario Outline: Get Change Request By Key - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMGNjOWI1NS1iMWEzLTQxODItYWY2Ni05MmNiZjEwNTM2MzQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NTUyNzA0LCJleHAiOjE1OTUxNTc1MDR9.WH2Gr5PfWwHYQ9VC7kA7CMBunDquvxeSfl4v758JrFnaLcPZ8ONgZm09n5QVfSZBBuDvGYj4_Y09gsp1lBj9fg"
    And I set header "changeRequestKey" parameter with value "<keyValue>"
    When I GET request to "/v1/change-request"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "changeRequestKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @getChangeRequestStatus404
  Scenario Outline: Get Change Request By Key - Task Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzMGNjOWI1NS1iMWEzLTQxODItYWY2Ni05MmNiZjEwNTM2MzQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NTUyNzA0LCJleHAiOjE1OTUxNTc1MDR9.WH2Gr5PfWwHYQ9VC7kA7CMBunDquvxeSfl4v758JrFnaLcPZ8ONgZm09n5QVfSZBBuDvGYj4_Y09gsp1lBj9fg"
    And I set header "changeRequestKey" parameter with value "<keyValue>"
    When I GET request to "/v1/change-request"
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