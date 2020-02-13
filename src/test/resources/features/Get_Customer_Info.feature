Feature: Contact Center - Customer Search

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @getCustomerInfoStatus401
  Scenario Outline: Get Customer Info - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    When I GET request to "/v1/customer"
    Then response status code should be 401
    And response body should contain value of "67555" for key "code"
    And response body should contain value of "Access token is invalid" for key "message"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |



  # Customer logs in. Then customer calls this API with access token
  @getCustomerInfo
  Scenario: Get Customer Info - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwOTE2MzkwLCJleHAiOjE4OTY1MjAzMzR9.vE7c2J1gsuAyv4bsP5H9VyIuFRU0xHjJqkabZkYroikFYfDhLt6mpn7f4UjeM_I-nxJYLGPya-sJxR0bB19IKw"
    When I GET request to "/v1/customer"
    Then response status code should be 200
    And response body should be following json
  """
    {
      "email": "onb_happy_path_1@hymnai.com",
      "fullName": "Ebru Soysal",
      "accountNumber": "10001530",
      "phoneNumber": "449999999999",
      "onboardingStatus": "REGISTRATION_COMPLETE",
      "key": "87889fe8-b1d2-4685-aaa6-d67f9c3a6697",
      "customerStatus": "ACTIVE"
    }
  """

