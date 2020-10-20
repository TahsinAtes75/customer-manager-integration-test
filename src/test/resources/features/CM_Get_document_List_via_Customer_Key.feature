Feature: Customer Manager-Document Service - Get Document List via Customer Key for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getDocumentListByCustomerKeyforCustomer
  Scenario: Get Document List via Customer Key for Customer - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyNTNjZTY2Yy0wNTkzLTRhMDQtODA5Mi0yYmRkNmI0ZTFjMDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5OGQ5N2UxYi00ZmJiLTRlM2YtODJjYi0yZDA1YjY0OTZhZjciLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMTA0MTY0LCJleHAiOjE2MDM3MDg5NjR9.qobJa2Jc1lToxr3cNLq5P9mn-WXVTw28cbzWVZXo_TGRfpvHb4eApWiOtah090PrwVzqqfKOCC9pWDokytcApg"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents"
    Then response status code should be 200
    And response body should be following json
   """
   {
  "contents": [
    {
      "documentKey": "0c128632-645a-4872-9bb2-57a13d4309c4",
      "customerKey": "98d97e1b-4fbb-4e3f-82cb-2d05b6496af7",
      "status": "clear",
      "type": "ID",
      "subType": "passport",
      "fileName": "1602776703193-DVLA-English-full-licence-sample_(1).jpg",
      "fileSize": 147637,
      "fileType": "jpg",
      "fileNameBack": "1602776704155-DVLA-English-full-licence-sample.jpg",
      "fileSizeBack": 9412,
      "fileTypeBack": "jpg",
      "createdAt": "2020-10-15T16:45:04"
    },
    {
      "documentKey": "077ecbbb-0cac-449e-a13a-71e9e1310ed0",
      "customerKey": "98d97e1b-4fbb-4e3f-82cb-2d05b6496af7",
      "status": "clear",
      "type": "PHOTO",
      "subType": "photo",
      "fileName": "1602776718317-DVLA-English-full-licence-sample.jpg",
      "fileSize": 12778,
      "fileType": "jpg",
      "createdAt": "2020-10-15T16:45:20"
    }
  ]
}
   """

  @getDocumentListByCustomerKeyforCustomer
  Scenario: Get Document List via Customer Key for Customer - Prospect Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNTJjNGFkNy02NDNlLTQ0NzctYjJjNC02ODUyNTkwMGE3OTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NTBmYjU2NC0xOWMxLTQ4ZTUtOGFlZC1mNTM3ZTgyYjQ5MjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMTgxNjYyLCJleHAiOjE2MDM3ODY0NjJ9._IZ9DZS63hvWDJMjAYQmdxbFweXW6DiknggQ8_bgIfU5Dh2XrMYKTbu8JMIysKkrSXDh0lp8B9fg1N-3MQ3fWQ"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents"
    Then response status code should be 200
    And response body should be following json
   """
   {
  "contents": []
   }
   """

    #this customer token belongs to customerManager341@yopmail.com
    #customer status:prospect, onboarding status: EMAIL_CAPTURED

  @getDocumentListByCustomerKeyforCustomerStatus400
  Scenario Outline: Get Document List via Customer Key for Customer - SortBy Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyNTNjZTY2Yy0wNTkzLTRhMDQtODA5Mi0yYmRkNmI0ZTFjMDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5OGQ5N2UxYi00ZmJiLTRlM2YtODJjYi0yZDA1YjY0OTZhZjciLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMTA0MTY0LCJleHAiOjE2MDM3MDg5NjR9.qobJa2Jc1lToxr3cNLq5P9mn-WXVTw28cbzWVZXo_TGRfpvHb4eApWiOtah090PrwVzqqfKOCC9pWDokytcApg"
    And I set query parameter "sortBy" with value "<value>"
    When I GET request to "/v1/documents"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Sort parameter is invalid" for key "errors[0].description"

    Examples:
      | value     |
      | created   |
      | -createdA |
      | FILE      |
      | +sub      |
      | -Size     |
      | +file     |

  @getDocumentListByCustomerKeyforCustomer
  Scenario Outline: Get Document List via Customer Key for Customer - SortBy Validation Test 1
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyNTNjZTY2Yy0wNTkzLTRhMDQtODA5Mi0yYmRkNmI0ZTFjMDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5OGQ5N2UxYi00ZmJiLTRlM2YtODJjYi0yZDA1YjY0OTZhZjciLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMTA0MTY0LCJleHAiOjE2MDM3MDg5NjR9.qobJa2Jc1lToxr3cNLq5P9mn-WXVTw28cbzWVZXo_TGRfpvHb4eApWiOtah090PrwVzqqfKOCC9pWDokytcApg"
    And I set query parameter "sortBy" with value "<value>"
    When I GET request to "/v1/documents"
    Then response status code should be 200

    Examples:
      | value      |
      | +createdAt |
      | -createdAt |
      | -subType   |
      | +subType   |
      | -fileSize  |
      | +fileSize  |


  @getDocumentListByCustomerKeyforCustomerStatus401
  Scenario Outline: Get Document List via Customer Key for Customer - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |

  @getDocumentListByCustomerKeyforCustomerStatus403
  Scenario Outline: Get Document List via Customer Key for Customer - Token Validation with Agent Token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents"
    Then response status code should be 403
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Method access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |  eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0NjYwNjBlNS1lZTc5LTQ3NjItOWIwOC1hZmZjNWE2YjdhZDgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDMxMjA4MjQsImV4cCI6MTYwMzcyNTYyNH0.se7JqUtY3DJXHy6mwLBbTZR2wJE1JCw9yc4ET2o9g54pGESi_JiK-J42vsFk1QGQLGDU_gCo-_B_jd9sCHNCIA                                                                                                                                                                                                                                                                                   |



