Feature: List Change Requests

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getChangeRequestsListStatus401
  Scenario Outline: Get Change Requests List - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/change-requests"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | abcdef                                                                                                                                                                                                                                                                             |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |

  @getChangeRequestsListStatus403
  Scenario Outline: Get Change Requests List - Token Validation with Agent Token
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/change-requests"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ODU0MTRjYy03OWQzLTQyMjktYWEyZC01N2RmMzQ1YzhiYTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZW1vMiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTQzNzk2MTMsImV4cCI6MTU5NDk4NDQxM30.xESjHkHVMBv_yrx6NdT9rsyv1fg-uSVnqNd1XOyqKBcEr9rJWlGgqPMEjAsBQkTnid2WzyQTS3D4ycy_ts0vuQ |

  @getChangeRequestsListbySortByValues
  Scenario Outline: Get Change Requests List by sortBy Values
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "<values>"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200
    Examples:
      |values              |
      |+type               |
      |-type               |
      |+status             |
      |-status             |
      |+verificationStatus |
      |-verificationStatus |

  @getChangeRequestsList
  Scenario: Get Change Requests List - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "1"
    And I set query parameter "offset" with value "1"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200
    And response body should be following json
        """
{
  "contents": [
    {
      "changeRequestKey": "7dc89ecd-1749-4e8b-85bd-4978d2663300",
      "type": "NAME_SURNAME_UPDATE",
      "payload": "{\"givenNames\":\"string\",\"surname\":\"string\"}",
      "existingValues": "{\"surname\":\"Can\",\"givenNames\":\"Sule\"}",
      "verificationStatus": "clear"
    }
  ],
  "pageable": {
    "sort": {
      "sorted": false,
      "unsorted": true,
      "empty": true
    },
    "pageSize": 1,
    "pageNumber": 1,
    "offset": 1,
    "paged": true,
    "unpaged": false
  }
}
        """


  @getChangeRequestsList
  Scenario: Get Change Requests List by limit value 2
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "2"
    And I set query parameter "offset" with value "1"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200
    And response body should be following json
          """
 {
  "contents": [
    {
      "changeRequestKey": "495c9197-5917-4bbc-8460-fd63f0130ed7",
      "type": "NAME_SURNAME_UPDATE",
      "payload": "{\"givenNames\":\"string123\",\"surname\":\"string\"}",
      "existingValues": "{\"surname\":\"Can\",\"givenNames\":\"Sule\"}",
      "verificationStatus": "clear"
    },
    {
      "changeRequestKey": "30ae9348-fb1d-4205-b63b-f1862d729055",
      "type": "NAME_SURNAME_UPDATE",
      "payload": "{\"givenNames\":\"string1237865348765834276\",\"surname\":\"stringjdshfkjhdskjafhkjdshfkads\"}",
      "existingValues": "{\"surname\":\"Can\",\"givenNames\":\"Sule\"}",
      "verificationStatus": "clear"
    }
  ],
  "pageable": {
    "sort": {
      "sorted": false,
      "unsorted": true,
      "empty": true
    },
    "pageSize": 2,
    "pageNumber": 1,
    "offset": 2,
    "paged": true,
    "unpaged": false
  }
}
          """

  @getChangeRequestsListbySortByType
  Scenario: Get Change Requests List by sortBy +type - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "+type"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200

  @getChangeRequestsListbySortByType
  Scenario: Get Change Requests List by sortBy -type - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "2"
    And I set query parameter "offset" with value "0"
    And I set query parameter "sortBy" with value "-type"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200

  @getChangeRequestsListbyStatusAndType
  Scenario: Get Change Requests List by Status And Type - Data Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag"
    And I set query parameter "limit" with value "3"
    And I set query parameter "offset" with value "1"
    And I set query parameter "sortBy" with value "-type"
    And I set query parameter "status" with value "COMPLETED"
    And I set query parameter "type" with value "NAME_SURNAME_UPDATE"
    When I GET request to "/v1/change-requests"
    Then response status code should be 200


  @getChangeRequestsListStatus200
  Scenario Outline: Get Change Requests List - limit, offset, sortBy ,status and type
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMTQ0YjJmOC04Yjk2LTQxZmItOTNiMS1lYzQyOGQyY2I1YTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0NzI4NzkzLCJleHAiOjE1OTUzMzM1OTN9.ej_Wm0Q6gopFt73BxhJmsReA-IIQUYJD9ktvVtGoXlpZbGC2fWXzSD_ZxFBNGE_aC6wxyviGwrmPgEHmtpMKag "
    And I set request body with information given in the following table
      | limit        | <limitValue>   |
      | offset       | <offsetValue>  |
      | sortBy       | <sortByValue>  |
      | status       | <statusValue>  |
      | type         | <typeValue>    |
    When I GET request to "/v1/change-requests"
    Then response status code should be 200

    Examples:
      | limitValue           |  typeValue         | offsetValue      |statusValue                        |sortByValue        |
      |  100                 |NAME_SURNAME_UPDATE | 0                |START_CHANGE_REQUEST               |+type              |
      |   2                  |ADDRESS_UPDATE      | 1                |START_PROOF_OF_ID_CHECK            |-type              |
      |   3                  |ADDRESS_UPDATE      | 2                |FINISH_PROOF_OF_ID_CHECK           |+status            |
      |   1                  |NAME_SURNAME_UPDATE | 1                |START_PROOF_OF_PHOTO_CHECK         |-status            |
      |   1                  |ADDRESS_UPDATE      | 1                |FINISH_PROOF_OF_PHOTO_CHECK        |+verificationStatus|
      |   1                  |                    | 1                |START_PROOF_OF_WATCHLIST_CHECK     |-verificationStatus|
      |   1                  |                    | 1                |FINISH_PROOF_OF_WATCHLIST_CHECK    |+verificationStatus|
      |   1                  |                    | 1                |START_PROOF_OF_EXTRA_DOCUMENT_CHECK|-status            |
      |   1                  |                    | 1                |START_PROOF_OF_ADDRESS_CHECK       |-type              |
      |   1                  |                    | 1                |COMPLETED                          |+type              |


