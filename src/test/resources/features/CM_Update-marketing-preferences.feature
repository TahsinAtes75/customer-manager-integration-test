Feature: Customer Manager - Update-Marketing-preference-for-customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @CmUpdateMarketingPreference401
  Scenario Outline:Update-Marketing-preference - Token Invalid
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | marketingPreference | true |
    When I PUT request to "/v1/customers/marketing-preference"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                                                                       |
      |                                                                                                                                                                                                                                                                                                                                  |
      | asd                                                                                                                                                                                                                                                                                                                              |
      | ayJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2OTlmNmZiNy03NzlmLTRkODItYWJlZS1iZGFhZDE0ZTcwZjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhOTcwZmVmMi1mMzA3LTRiYTEtYjQ5OC1kY2I5NjI0Y2RkOTAiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjA1MDA0OTQyLCJleHAiOjE2MDU2MDk3NDJ9.Mo1o7dNiiYzirPm16hHufiafLsHuorymyD9gGfTPQpQgTNKeKGIs35o4xYYq8rMnA6tN5RMYELII9N15RLENZQ |


  @CmUpdateMarketingPreference400
  Scenario Outline:Update-Marketing-preference - 400
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmMjg3ZDNjMC1kZDhkLTQ4OGYtOWI0YS02ZDA4MTA0OWJiOTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIxOTg4YTA5OC1kNzRkLTQwNzAtOWVjYi05MmZmZTdiMDM5NTMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjA1MDk1NTQzLCJleHAiOjE2MDU3MDAzNDN9.viN2ry7HDD5zlbdSrlQu9yUocguWA7OUu9Kcan3CVCGqYNxvwVF0KBTBnr4pl9NEPs5mijqOFbKcSD7DbZOsww"
    And I set request body with information given in the following table
      | marketingPreference | <marketingPreferenceValue> |
    When I PUT request to "/v1/customers/marketing-preference"
    Then response status code should be 400
    And response body should contain value of "69713" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | marketingPreferenceValue | message                   |
      | jkl                      | Marketing preference should be true or false |
      | swerggffd                | Marketing preference should be true or false |
      | 3452                     | Marketing preference should be true or false |


  @CmUpdateMarketingPreference403
  Scenario:Update-Marketing-preference - Agent-Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMWI3NDY0Ny1mMTJiLTRiMjQtOGUwYi0zYmYwMThjZWRiYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBR0VOVHJhc2l0Iiwic2NvcGUiOiJBR0VOVCIsImlhdCI6MTYwNTAxMTM5MiwiZXhwIjoxNjA1NjE2MTkyfQ.AAZSO9wIwQ1eYMLM6gGedyVw_NXMQ1tWYIL6AQtUxhu0EMimZSbxZC0RkkkluskNZmM09FDxQ-04mAISBgHNRg"
    And I set request body with information given in the following table
      | marketingPreference | true |
    When I PUT request to "/v1/customers/marketing-preference"
    Then response status code should be 403
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Method access denied" for key "errors[0].description"


  @CmUpdateMarketingPreference200
  Scenario:Update-Marketing-preference - HappyPathTrue
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmMjg3ZDNjMC1kZDhkLTQ4OGYtOWI0YS02ZDA4MTA0OWJiOTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIxOTg4YTA5OC1kNzRkLTQwNzAtOWVjYi05MmZmZTdiMDM5NTMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjA1MDk1NTQzLCJleHAiOjE2MDU3MDAzNDN9.viN2ry7HDD5zlbdSrlQu9yUocguWA7OUu9Kcan3CVCGqYNxvwVF0KBTBnr4pl9NEPs5mijqOFbKcSD7DbZOsww"
    And I set request body with information given in the following table
      | marketingPreference | true |
    When I PUT request to "/v1/customers/marketing-preference"
    Then response status code should be 200
    And response body should be following json
"""
{
  "customerKey": "1988a098-d74d-4070-9ecb-92ffe7b03953",
  "customerEmail": "javiar@yopmail.com",
  "emailVerified": true,
  "phoneNumber": "449876543211",
  "phoneVerified": true,
  "givenNames": "Jonh",
  "surname": "jojo",
  "fullName": "Jonh jojo",
  "preferredName": "jo",
  "dateOfBirth": "1990-04-16",
  "onboardingStatus": "REGISTRATION_COMPLETE",
  "customerStatus": "ACTIVE",
  "idStatus": "clear",
  "photoStatus": "clear",
  "addressStatus": "clear",
  "watchlistStatus": "clear",
  "duplicateStatus": "clear",
  "marketingPreference": true
}
"""

  @CmUpdateMarketingPreference200
  Scenario:Update-Marketing-preference - HappyPathFalse
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmMjg3ZDNjMC1kZDhkLTQ4OGYtOWI0YS02ZDA4MTA0OWJiOTQiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIxOTg4YTA5OC1kNzRkLTQwNzAtOWVjYi05MmZmZTdiMDM5NTMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjA1MDk1NTQzLCJleHAiOjE2MDU3MDAzNDN9.viN2ry7HDD5zlbdSrlQu9yUocguWA7OUu9Kcan3CVCGqYNxvwVF0KBTBnr4pl9NEPs5mijqOFbKcSD7DbZOsww"
    And I set request body with information given in the following table
      | marketingPreference | false |
    When I PUT request to "/v1/customers/marketing-preference"
    Then response status code should be 200
    And response body should be following json
"""
{
  "customerKey": "1988a098-d74d-4070-9ecb-92ffe7b03953",
  "customerEmail": "javiar@yopmail.com",
  "emailVerified": true,
  "phoneNumber": "449876543211",
  "phoneVerified": true,
  "givenNames": "Jonh",
  "surname": "jojo",
  "fullName": "Jonh jojo",
  "preferredName": "jo",
  "dateOfBirth": "1990-04-16",
  "onboardingStatus": "REGISTRATION_COMPLETE",
  "customerStatus": "ACTIVE",
  "idStatus": "clear",
  "photoStatus": "clear",
  "addressStatus": "clear",
  "watchlistStatus": "clear",
  "duplicateStatus": "clear",
  "marketingPreference": false
}
"""


