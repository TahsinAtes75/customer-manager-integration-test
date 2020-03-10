Feature: Contact Center - Customer Search

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerInfoStatus401
  Scenario Outline: Get Customer Info - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/customer"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |



  # Customer logs in. Then customer calls this API with access token
  @getCustomerInfo
  Scenario: Get Customer Info - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4MWU4NTE5Yy03ZWE0LTQ2MjMtOGUyNC1jOTZkY2MxNWY1NWYiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgzODUxMzczLCJleHAiOjE4OTY1MjAzMzR9.Tyw9Mz7WiWB8uJOG2JhMDSXWyZFblosFB4vTKu3YeOe1sbvfPZFh0Nj55-hxEK4ugO2K9TnNop80dgg8ozDCqQ"
    When I GET request to "/v1/customer"
    Then response status code should be 200
    And response body should be following json
  """
    {
      "customerKey": "81e8519c-7ea4-4623-8e24-c96dcc15f55f",
      "customerEmail": "onb_happy_path_2@hymnai.com",
      "emailVerified": true,
      "phoneNumber": "449191919192",
      "phoneVerified": true,
      "givenNames": "Ebru",
      "surname": "Soysal",
      "fullName": "Ebru Soysal",
      "dateOfBirth": "1982-01-01",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "customerStatus": "ACTIVE",
      "address":
      {
        "line1": "3 Queen's Road",
        "line2": "",
        "town": "Reading",
        "county": "Berkshire",
        "country": "UK",
        "postcode": "RG1 4AP",
        "verified": false
      }
    }
  """


  @getCustomerInfoStatus404
  Scenario: Get Customer Info - No Customer Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4MWU4NTE5Yy03ZWE0LTQ2MjMtOGUyNC1jOTZkY2MxNWY1NWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgzODUxMzczLCJleHAiOjE4OTY1MjAzMzR9.jGuzfxihwgXEHNLMLEqCmZ1AVSMCudPz5M94rjzxzuw9fbxOaUWlnf60yEfwqXqE06anGqXqrLmFhZCiRQ1FXQ"
    When I GET request to "/v1/customer"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: 81e8519c-7ea4-4623-8e24-c96dcc15f55d" for key "errors[0].description"
