Feature: Customer Manager - Document type/subtype list

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getDocumentTypeSubtypeListStatus401
  Scenario Outline: Document type/subtype list - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/document-types"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @getDocumentTypeSubtypeList
  Scenario: Document type/subtype list - Happy Path with Agent Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjNzQ1NGNjZS1mY2VhLTQyZDAtYmJhOC02MjE4YTAxMGUyZTAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDM3MjI0MzksImV4cCI6MTYwNDMyNzIzOX0.mWKRCs5JitUfRbCTo3glYz27329AyO_hjNa6vXk6f-XGC27rE1IJD1VE3ZUJdn5OZMP3JlXTl-s7Y2ZBzIDtvg"
    When I GET request to "/v1/document-types"
    Then response status code should be 200
    And response body should be following json
  """
   {
  "ID": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit"
  ],
  "PHOTO": [
    "photo"
  ],
  "WATCHLIST": [],
  "ADDRESS": [
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "unknown"
  ],
  "NAME_SURNAME_DOCUMENTS": [
    "deed_pool",
    "marriage_certificate",
    "divorce_certificate",
    "unknown"
  ],
  "MANUAL_TASK": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit",
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "marriage_certificate",
    "divorce_certificate",
    "deed_pool",
    "photo",
    "unknown"
  ],
  "NONE": []
}
  """


  @getDocumentTypeSubtypeList
  Scenario: Document type/subtype list - Happy Path with Active Customer Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5NDA1YTdmYS0yMzFiLTQwYzEtYjE3ZC0yNTliYjYzNmI2ZWMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1ODVmZGY3Zi04ZGI5LTRlYTEtODgyNi1hNzU3ODZmNzRlNWUiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzNzIzNzI4LCJleHAiOjE2MDQzMjg1Mjh9.WMoEtggQB-_LTeiVi59YTzYlNpqyCpuEaKlRtsdFUENS1WI4tQ1NU2Il-9xvJHb7eVxOg0P7erDTOuh_vzVRaA"
    When I GET request to "/v1/document-types"
    Then response status code should be 200
    And response body should be following json
  """
   {
  "ID": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit"
  ],
  "PHOTO": [
    "photo"
  ],
  "WATCHLIST": [],
  "ADDRESS": [
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "unknown"
  ],
  "NAME_SURNAME_DOCUMENTS": [
    "deed_pool",
    "marriage_certificate",
    "divorce_certificate",
    "unknown"
  ],
  "MANUAL_TASK": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit",
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "marriage_certificate",
    "divorce_certificate",
    "deed_pool",
    "photo",
    "unknown"
  ],
  "NONE": []
}
  """

    # this customer token belongs to customerManager286@yopmail.com which is onboarding status is:REGISTRATION_COMPLETE

  @getDocumentTypeSubtypeList
  Scenario: Document type/subtype list - Happy Path with Prospect Customer Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxNzY5NThkMC01NDFiLTQ0ZmUtYjZmZC1lZDkzMWY0YzQ5NjQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjOGZmZmZkZC1lNTYzLTRlNWEtYjg4MS0xNzM2NWFlZjIxNjUiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzNzI0MDc2LCJleHAiOjE2MDQzMjg4NzZ9.3fqbNsSAxXcamBmTsZX--J7astxgCDSZw7st2GLAeGEnFHIZ061xTeOOJMR-gZoy-e_imOO8k-1k7u4Vy7krxw"
    When I GET request to "/v1/document-types"
    Then response status code should be 200
    And response body should be following json
  """
   {
  "ID": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit"
  ],
  "PHOTO": [
    "photo"
  ],
  "WATCHLIST": [],
  "ADDRESS": [
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "unknown"
  ],
  "NAME_SURNAME_DOCUMENTS": [
    "deed_pool",
    "marriage_certificate",
    "divorce_certificate",
    "unknown"
  ],
  "MANUAL_TASK": [
    "passport",
    "driving_licence",
    "national_identity_card",
    "voter_id",
    "work_permit",
    "bank_building_society_statement",
    "utility_bill",
    "council_tax",
    "benefit_letters",
    "marriage_certificate",
    "divorce_certificate",
    "deed_pool",
    "photo",
    "unknown"
  ],
  "NONE": []
}
  """
     # this customer token belongs to customerManager782@yopmail.com which is onboarding status is:EMAIL_CAPTURED