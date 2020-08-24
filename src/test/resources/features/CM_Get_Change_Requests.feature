Feature: Get Change Requests

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getChangeRequestsStatus401
  Scenario Outline: Get Change Requests - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | abcdef                                                                                                                                                                                                                                                                             |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |

  @getChangeRequestsStatus400
  Scenario Outline: Get Change Requests By Key - Invalid Key
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2YTM3ZjdiOS05MzFkLTQ4MjItODE3YS05ZjE2NDk5NDQzNDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgwMzcwNzgsImV4cCI6MTU5ODY0MTg3OH0.eQyLPCQGcEmopgLIt8F2tJn14IOxOVINwir5-ymf51iVjWMk2X5EqpIVvMI91s8fLi9gqF9zfrql4CBpzAQ6aw"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "customerKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      | abc                                   |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |

  @getChangeRequestsStatus403
  Scenario Outline: Get Change Requests  - Token Validation with customer Token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiNjRmMTg0Mi03ODY0LTQ3NzYtYTYzZS1mYWQ0NTBmMTIzOTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwZmM1NDViMC0xNzZlLTQ5MWYtOGVjOC0wNmE5OWRhM2NkZTAiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4MDQ0NzYyLCJleHAiOjE1OTg2NDk1NjJ9.KRIAg_8fn1yr46se6CELWYvrLGMmcrLariRFOh1QvSC4nfcLdlY7KStBsu0YZvHYR0diU513C8ySymazjEmxhA|

  @getChangeRequestsbySortByValues
  Scenario Outline: Get Change Requests  by sortBy Values
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2YTM3ZjdiOS05MzFkLTQ4MjItODE3YS05ZjE2NDk5NDQzNDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgwMzcwNzgsImV4cCI6MTU5ODY0MTg3OH0.eQyLPCQGcEmopgLIt8F2tJn14IOxOVINwir5-ymf51iVjWMk2X5EqpIVvMI91s8fLi9gqF9zfrql4CBpzAQ6aw"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "<values>"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200
    Examples:
      |values              |
      |+type               |
      |-type               |
      |+status             |
      |-status             |
      |+verificationStatus |
      |-verificationStatus |

  @getChangeRequests
  Scenario: Get Change Requests  - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwOGFiNzlkZi1jYjAwLTQxMmYtYmUyNS1lNzhmNDI5OTM5OTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyNTkyNzksImV4cCI6MTU5ODg2NDA3OX0.6kYdXzGQWB7evYoGijfQrS0SvJDXq0WtyPfUXbwuvADEoXDieO_cJgsWgDiCGt6hrwWS8NQqc0-0pQFXz2OxNg"
    And I set header "customerKey" parameter with value "6383e064-fcac-42ff-9960-a8fe1bf3412d"
    And I set query parameter "limit" with value "1"
    And I set query parameter "offset" with value "1"
    And I set query parameter "sortBy" with value "-status"
    And I set query parameter "type" with value "ADDRESS_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "contents": [
    {
      "changeRequestKey": "d63b7b0c-b76b-4fd6-97c4-d415148b9be0",
      "type": "ADDRESS_UPDATE",
      "payload": "{\"line1\":\"Cardiff Visitor Centre, The Old Library, Trinity Street, Cardiff, South Glamorgan\",\"town\":\"Cardiff\",\"country\":\"GBR\",\"postcode\":\"CF10 1BH\",\"county\":\"South Glamorgan\",\"verified\":false}",
      "existingValues": "{\"country\":\"GBR\",\"town\":\"Manchester\",\"county\":\"\",\"postcode\":\"M44 5FF\",\"line2\":\"\",\"line1\":\"10 Lords Street, Cadishead, Manchester\"}",
      "verificationStatus": "clear"
    }
  ],
  "pageable": {
    "sort": {
      "sorted": true,
      "unsorted": false,
      "empty": false
    },
    "pageSize": 1,
    "pageNumber": 1,
    "offset": 1,
    "paged": true,
    "unpaged": false
  }
}
    """



  @getChangeRequest1
  Scenario: Get Change Requests-1  - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwOGFiNzlkZi1jYjAwLTQxMmYtYmUyNS1lNzhmNDI5OTM5OTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyNTkyNzksImV4cCI6MTU5ODg2NDA3OX0.6kYdXzGQWB7evYoGijfQrS0SvJDXq0WtyPfUXbwuvADEoXDieO_cJgsWgDiCGt6hrwWS8NQqc0-0pQFXz2OxNg"
    And I set header "customerKey" parameter with value "2739077a-22d3-4214-8613-74ba48f8e47d"
    And I set query parameter "limit" with value "1"
    And I set query parameter "offset" with value "1"
    And I set query parameter "sortBy" with value "-status"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200
    And response body should be following json
    """
   {
  "contents": [
    {
      "changeRequestKey": "3db5a305-cfee-4188-aae0-df16e16f9567",
      "type": "NAME_SURNAME_UPDATE",
      "payload": "{\"givenNames\":\"adfa\",\"surname\":\"adsf\"}",
      "existingValues": "{\"surname\":\"Tatlises\",\"givenNames\":\"Ibrahim\"}",
      "verificationStatus": "clear"
    }
  ],
  "pageable": {
    "sort": {
      "sorted": true,
      "unsorted": false,
      "empty": false
    },
    "pageSize": 1,
    "pageNumber": 1,
    "offset": 1,
    "paged": true,
    "unpaged": false
  }
}
    """





  @getChangeRequestsbySortByType
  Scenario: Get Change Requests by sortBy +type - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2YTM3ZjdiOS05MzFkLTQ4MjItODE3YS05ZjE2NDk5NDQzNDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgwMzcwNzgsImV4cCI6MTU5ODY0MTg3OH0.eQyLPCQGcEmopgLIt8F2tJn14IOxOVINwir5-ymf51iVjWMk2X5EqpIVvMI91s8fLi9gqF9zfrql4CBpzAQ6aw"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+type"
    And I set query parameter "status" with value "COMPLETED"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200

  @getChangeRequestsbySortByType
  Scenario: Get Change Requests by sortBy -type - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2YTM3ZjdiOS05MzFkLTQ4MjItODE3YS05ZjE2NDk5NDQzNDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgwMzcwNzgsImV4cCI6MTU5ODY0MTg3OH0.eQyLPCQGcEmopgLIt8F2tJn14IOxOVINwir5-ymf51iVjWMk2X5EqpIVvMI91s8fLi9gqF9zfrql4CBpzAQ6aw"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "-type"
    And I set query parameter "status" with value "COMPLETED"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200

  @getChangeRequestsStatus200
  Scenario Outline: Get Change Requests  - limit, offset, sortBy ,status and type
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwOGFiNzlkZi1jYjAwLTQxMmYtYmUyNS1lNzhmNDI5OTM5OTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyNTkyNzksImV4cCI6MTU5ODg2NDA3OX0.6kYdXzGQWB7evYoGijfQrS0SvJDXq0WtyPfUXbwuvADEoXDieO_cJgsWgDiCGt6hrwWS8NQqc0-0pQFXz2OxNg"
    And I set header "customerKey" parameter with value "0fc545b0-176e-491f-8ec8-06a99da3cde0"
    And I set request body with information given in the following table
      | limit        | <limitValue>   |
      | offset       | <offsetValue>  |
      | sortBy       | <sortByValue>  |
      | status       | <statusValue>  |
      | type         | <typeValue>    |
    When I GET request to "/v1/change-requests/agent"
    Then response status code should be 200
    Examples:
      | limitValue           |  typeValue         | offsetValue      |statusValue                        |sortByValue        |
      |  100                 |NAME_SURNAME_UPDATE | 0                |START_CHANGE_REQUEST               |+type              |
      |   2                  |ADDRESS_UPDATE      | 1                |START_PROOF_OF_ID_CHECK            |-type              |
      |   3                  |ADDRESS_UPDATE      | 2                |FINISH_PROOF_OF_ID_CHECK           |+status            |
      |   1                  |NAME_SURNAME_UPDATE | 1                |START_PROOF_OF_PHOTO_CHECK         |-status            |
      |   1                  |ADDRESS_UPDATE      | 1                |FINISH_PROOF_OF_PHOTO_CHECK        |+verificationStatus|
      |   1                  |NAME_SURNAME_UPDATE | 1                |START_PROOF_OF_WATCHLIST_CHECK     |-verificationStatus|
      |   1                  |ADDRESS_UPDATE      | 1                |FINISH_PROOF_OF_WATCHLIST_CHECK    |+verificationStatus|
      |   1                  |ADDRESS_UPDATE      | 1                |START_PROOF_OF_EXTRA_DOCUMENT_CHECK|-status            |
      |   1                  |NAME_SURNAME_UPDATE | 1                |START_PROOF_OF_ADDRESS_CHECK       |-type              |
      |   1                  |NAME_SURNAME_UPDATE | 1                |COMPLETED                          |+type              |

