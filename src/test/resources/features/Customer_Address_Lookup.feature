Feature: Customer Address Lookup

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"


  @getCustomerAddressLookupStatus401
  Scenario Outline: Customer Address Lookup  - Token Validation with invalid tokens and verify token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set path parameter "postcode" with value "SW15 3DP"
    When I GET request to "/v1/external/address/{postcode}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzZTQ5ZDdhYS1jZjc3LTQ5OWUtODViOS04M2NiYTQxNWJhYjMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4Njk2NzY4NywiZXhwIjoxOTAyNTAyMDkyfQ.fAyZfl_addQq2E0L5POJxUtuNNGMknWklp6J2vquqoJTuMOIxMWOe8lJNecP05imuAb6JwyG8XOn2wwFMo37CA |
  ###
  # Last validation for when we called the api with "verify token"
  ###

  @getCustomerAddressLookupStatus403
  Scenario Outline: Customer Address Lookup  - Token Validation with agent token and customer token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set path parameter "postcode" with value "SW15 3DP"
    When I GET request to "/v1/external/address/{postcode}"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |  eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4MGVhZjFiNy0xNGE5LTQ4MjYtODY1Mi02MGNjY2JkM2Q2NzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFJhYmlhIiwic2NvcGUiOiJBR0VOVCIsImlhdCI6MTU4Njk2MTQ0MCwiZXhwIjoxOTAyNDk0NDUxfQ.uDshnfLeKykyKy5RQG38VzfNQfRnzAGPgmq9uoUWsrIA2sPrhcAUEo93Xx142LyI8lO24ajkqsRIMUhROhbdKQ                                            |
      |  eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5NDIwYTIwOS1lODhkLTRiNjUtYTY0NC1kMWQzNjNjNzU5YTIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTU3NjU5My1mYWEwLTRjNTgtYTI5NS0wZDFiMjY5MDYxMDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg3MDM1NjQ1LCJleHAiOjE5MDI1Njg1MzF9.fjt_6OzKCVGz-IdRqlLezTI47zw1B-lXNSCtpkkkmVSdgRHbR3T1ReC0JZ3HcPGIOMH_CFpLixOGcFUkmSCjjg     |


  @getCustomerAddressLookupStatus200
  Scenario: Customer Address Lookup  - Token Validation with Onboarding token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YWIzMDBiYS0yYWM0LTQ4NGItYTQzOS1lNTdjZTRjOWE1ZjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODY5NjgxMjUsImV4cCI6MTkwMjUwMzc4M30.WyPC_RySFaEcHvamDI59vy379WlHz94pHkk5KzzI6XWCiewBENUWnD5TNBZgU2kK_rpB4xjSe0ujy-whfuTb0g"
    And I set path parameter "postcode" with value "SW15 3DP"
    When I GET request to "/v1/external/address/{postcode}"
    Then response status code should be 200


  @getCustomerAddressLookupStatus400
  Scenario Outline: Customer Address Lookup  - Postcode Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YWIzMDBiYS0yYWM0LTQ4NGItYTQzOS1lNTdjZTRjOWE1ZjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODY5NjgxMjUsImV4cCI6MTkwMjUwMzc4M30.WyPC_RySFaEcHvamDI59vy379WlHz94pHkk5KzzI6XWCiewBENUWnD5TNBZgU2kK_rpB4xjSe0ujy-whfuTb0g"
    And I set path parameter "postcode" with value "<postcodeValue>"
    When I GET request to "/v1/external/address/{postcode}"
    Then response status code should be 400
    And response body should contain value of "65025" for key "errors[0].code"
    And response body should contain value of "Your postcode is not valid" for key "errors[0].description"

    Examples:
      | postcodeValue           |
      | VA 22102                |
      | ASS                     |
      | B33 00TH                |


  @getCustomerAddressLookupStatus404
  Scenario: Customer Address Lookup  - Postcode Validation empty postcode
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YWIzMDBiYS0yYWM0LTQ4NGItYTQzOS1lNTdjZTRjOWE1ZjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODY5NjgxMjUsImV4cCI6MTkwMjUwMzc4M30.WyPC_RySFaEcHvamDI59vy379WlHz94pHkk5KzzI6XWCiewBENUWnD5TNBZgU2kK_rpB4xjSe0ujy-whfuTb0g"
    And I set path parameter "postcode" with value ""
    When I GET request to "/v1/external/address/{postcode}"
    Then response status code should be 404
    And response body should contain value of "Not Found" for key "error"
    And response body should contain value of "No message available" for key "message"