Feature: Customer Service - Get Document List Via Customer Key or Change Request Key

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @getDocumentListByCustomerKeyOrChangeRequestKey
  Scenario: Get Document List Via Customer Key or Change Request Key - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxNzg1ZTM1Yy04MDVhLTQwMjQtOGI0YS05MjQ2MGI1M2IxMDgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAzMzY0MDIsImV4cCI6MTYwMDk0MTIwMn0.vAvRtH6B-eqrM7uNcKrTaQXnjNnwb0UvUWAZhmHjuLQk8cThs046wYuTKSlXJvLq_bgdgIKgukbP3WyFGvFA6g"
    And I set header "changeRequestKey" parameter with value "0486d83e-9e0a-4c67-a44b-5bda737fb552"
    And I set header "customerKey" parameter with value "     "
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 200
    And response body should be following json
   """
   {
  "contents": [
    {
      "documentKey": "8658b4fc-e80d-4dc8-a61a-54a063069d87",
      "customerKey": "63a37a82-e4f0-4481-a624-368960f3ea4c",
      "userKey": "aac54a15-3166-4a3e-8d67-16527cb7375b",
      "userUsername": "Agent999",
      "userFullName": "elf Alp",
      "authorityId": "111",
      "status": "clear",
      "type": "ADDRESS",
      "subType": "council_tax",
      "fileName": "1595519089587-councilTax.png",
      "fileSize": 299821,
      "fileType": "png",
      "title": "tax bill",
      "issuedAt": "2020-07-08",
      "createdAt": "2020-07-23T15:44:49"
    }
  ]
}
   """


  @getDocumentListByCustomerKeyOrChangeRequestKey
  Scenario: Get Document List Via Customer Key or Change Request Key - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxNzg1ZTM1Yy04MDVhLTQwMjQtOGI0YS05MjQ2MGI1M2IxMDgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAzMzY0MDIsImV4cCI6MTYwMDk0MTIwMn0.vAvRtH6B-eqrM7uNcKrTaQXnjNnwb0UvUWAZhmHjuLQk8cThs046wYuTKSlXJvLq_bgdgIKgukbP3WyFGvFA6g"
    And I set header "changeRequestKey" parameter with value " "
    And I set header "customerKey" parameter with value "f56372da-88d5-4bd1-a424-f79814c16378"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 200
    And response body should be following json
    """
    {
  "contents": [
    {
      "documentKey": "05bb8f57-8b8a-4f17-adb7-33a299e90bcf",
      "customerKey": "f56372da-88d5-4bd1-a424-f79814c16378",
      "status": "clear",
      "type": "ID",
      "subType": "driving_licence",
      "fileName": "1600338358273-sample_driving_licence-8f798a3e.png",
      "fileSize": 490408,
      "fileType": "png",
      "createdAt": "2020-09-17T10:25:59"
    },
    {
      "documentKey": "1aad124d-9590-45d9-bd0f-249c2fa75e13",
      "customerKey": "f56372da-88d5-4bd1-a424-f79814c16378",
      "status": "clear",
      "type": "PHOTO",
      "subType": "photo",
      "fileName": "1600338397834-sample_photo-e5e3561c.png",
      "fileSize": 536630,
      "fileType": "png",
      "createdAt": "2020-09-17T10:26:39"
    }
  ]
}
    """

  @getDocumentListByCustomerKeyOrChangeRequestKey
  Scenario Outline: Get Document List Via Customer Key or Change Request Key - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxNzg1ZTM1Yy04MDVhLTQwMjQtOGI0YS05MjQ2MGI1M2IxMDgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAzMzY0MDIsImV4cCI6MTYwMDk0MTIwMn0.vAvRtH6B-eqrM7uNcKrTaQXnjNnwb0UvUWAZhmHjuLQk8cThs046wYuTKSlXJvLq_bgdgIKgukbP3WyFGvFA6g"
    And I set header "changeRequestKey" parameter with value "0486d83e-9e0a-4c67-a44b-5bda737fb552"
    And I set header "customerKey" parameter with value "     "
    And I set query parameter "sortBy" with value "<value>"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 200

    Examples:
    |value        |
    | +createdAt  |
    |  -createdAt |
    |  -subType   |
    |  +subType   |




  @getDocumentListByCustomerKeyOrChangeRequestKeyStatus401
  Scenario Outline: Get Document List Via Customer Key or Change Request Key - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "changeRequestKey" parameter with value "  "
    And I set header "customerKey" parameter with value "63a37a82-e4f0-4481-a624-368960f3ea4c"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |

  @getDocumentListByCustomerKeyOrChangeRequestKeyStatus400
  Scenario Outline: Get Document List Via Customer Key or Change Request Key - Invalid customerKey
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMzQzMmUzMy1kNzIwLTQ2NzItOGZhOC04OTNiOTg1MmU5YTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFBodSIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAyNDg3NTMsImV4cCI6MTYwMDg1MzU1M30.IkCvRfEnHhzo4OMdFfwidq7iq1QiWz15TFKAxSgxnagH_Nb8sd6UWCW3VBF4QlFj3VCncF1VQdYTpVvV0Th0tA"
    And I set header "changeRequestKey" parameter with value "  "
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "customerKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @getDocumentListByCustomerKeyOrChangeRequestKeyStatus400
  Scenario Outline: Get Document List Via Customer Key or Change Request Key - Invalid customerKey
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMzQzMmUzMy1kNzIwLTQ2NzItOGZhOC04OTNiOTg1MmU5YTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFBodSIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAyNDg3NTMsImV4cCI6MTYwMDg1MzU1M30.IkCvRfEnHhzo4OMdFfwidq7iq1QiWz15TFKAxSgxnagH_Nb8sd6UWCW3VBF4QlFj3VCncF1VQdYTpVvV0Th0tA"
    And I set header "changeRequestKey" parameter with value "<keyValue>  "
    And I set header "customerKey" parameter with value ""
    And I set query parameter "sortBy" with value "+createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "changeRequestKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |

  @getDocumentListByCustomerKeyOrChangeRequestKeyStatus404
  Scenario Outline:  Get Document List Via Customer Key or Change Request Key - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhMzQzMmUzMy1kNzIwLTQ2NzItOGZhOC04OTNiOTg1MmU5YTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFBodSIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDAyNDg3NTMsImV4cCI6MTYwMDg1MzU1M30.IkCvRfEnHhzo4OMdFfwidq7iq1QiWz15TFKAxSgxnagH_Nb8sd6UWCW3VBF4QlFj3VCncF1VQdYTpVvV0Th0tA"
    And I set header "changeRequestKey" parameter with value "  "
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set query parameter "sortBy" with value "-createdAt"
    When I GET request to "/v1/documents/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |
