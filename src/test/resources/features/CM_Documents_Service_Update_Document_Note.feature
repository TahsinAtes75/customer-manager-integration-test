Feature: Customer Manager - Document Service - Update Document Note

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  @updateDocumentNoteHappyPath
  Scenario: Update Document Note - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 200


  @updateDocumentNoteStatus400
  Scenario: Update Document Note - Agent can only change his own document note
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "ee5f106d-2bd8-4278-9d9b-4f38000bb99f"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can not change Agent2 document notes",
  "id": 15
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 400
    And response body should contain value of "65039" for key "errors[0].code"
    And response body should contain value of "Document note does not belong to user" for key "errors[0].description"

  ##
  # Agent access token belongs to user_id:15
  # Document id:15 belongs to user_id:17
  ##

  @updateDocumentNoteStatus401
  Scenario Outline: Update Document Note - Token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4MTEzMzc4OS01NDE4LTQzZjctYjUzMy0yNDA0ZTIzMDNlNzQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYjY1ZTYyMC1mNzA5LTQ5ZDQtOWQwYi03ZmVmNzNhYjE5NzAiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU5ODUzMDM5NSwiZXhwIjoxNTk4NjE2Nzk1fQ.IOFsm3OQn6ELfq61IolZwV4j9B7KLV8BpgrDv4Ll0wcahGPK89KNyubpOY9eD9hLjVH-V-bLaFd8yPWQYH4hlA |

    #Last validation with verification access token


  @updateDocumentNoteStatus403
  Scenario Outline: Update Document Note - Token Validation with Customer Token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5NDIwYTIwOS1lODhkLTRiNjUtYTY0NC1kMWQzNjNjNzU5YTIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTU3NjU5My1mYWEwLTRjNTgtYTI5NS0wZDFiMjY5MDYxMDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg3MDM1NjQ1LCJleHAiOjE5MDI1Njg1MzF9.fjt_6OzKCVGz-IdRqlLezTI47zw1B-lXNSCtpkkkmVSdgRHbR3T1ReC0JZ3HcPGIOMH_CFpLixOGcFUkmSCjjg |


  @updateDocumentNoteStatus400
  Scenario Outline: Update Document Note - Document Key length Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "<documentKeyValue>"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "length must be 36" for key "errors[0].description"


    Examples:
      | documentKeyValue                                    |
      |                                                     |
      | as.?                                                |
      | 35f0ea62-0681                                       |
      | 35f0ea62-0681-4508-9a7e-cc4013dbd48d01010101010     |

  @updateDocumentNoteStatus400
  Scenario Outline: Update Document Note - ID Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": "<idValue>"
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 400
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Http Message Not Readable" for key "errors[0].description"


    Examples:
      |idValue                                              |
      | as.?                                                |
      | 35f0ea62-0681                                       |
      | 35f0ea62-0681-4508-9a7e-cc4013dbd48d01010101010     |

  @updateDocumentNoteStatus404
  Scenario Outline: Update Document Note - Document Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
     """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": "<idValue>"
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 404
    And response body should contain value of "65038" for key "errors[0].code"
    And response body should contain value of "Document note not found with for <idValue>" for key "errors[0].description"

    Examples:
      |idValue |
      | 100    |
      | 890    |
      | 48     |


  @updateDocumentNoteStatus404
  Scenario Outline: Update Document Note - Document Note Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "<documentKeyValue>"
    And I set request body with information given in the following json
      """
   {
  "agentNote": "Agent1 can change own document notes",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 400
    And response body should contain value of "65040" for key "errors[0].code"
    And response body should contain value of "Document note does not belong to document" for key "errors[0].description"

    Examples:
      | documentKeyValue                     |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |
      | 765b46b8-583e-4266-9a2b-e129a7ba2bb3 |
      | 05e93d79-ca23-4759-b0c0-75ee3c8cc77a |
    ##
  # document key3: "deleted document key"
  # document key4: "task key"
   ##

  @updateDocumentNoteStatus400
  Scenario: Create Document Note - Message Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set header "key" parameter with value "8a82dc6f-bb58-46b3-823e-0520ad51c2d5"
    And I set request body with information given in the following json
      """
   {
  "agentNote": "",
  "id": 2
   }
     """
    When I PUT request to "/v1/documents/notes"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "size must be between 1 and 2048" for key "errors[0].description"

