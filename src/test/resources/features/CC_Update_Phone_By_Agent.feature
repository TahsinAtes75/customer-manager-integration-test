Feature: Contact Center - Edit Customer's Phone Number by Agent

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @ccUpdatePhoneNumberByAgentStatus401
  Scenario Outline: CC Edit Phone Number by Agent - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @ccUpdatePhoneNumberByAgentStatus401
  Scenario: CC Edit Phone Number by Agent - Expired Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @ccUpdatePhoneNumberByAgentStatus403
  Scenario: CC Edit Phone Number by Agent - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @ccUpdatePhoneNumberByAgentStatus400
  Scenario Outline: CC Edit Phone Number by Agent - customerKey Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjM4NzNjMy1hZmMxLTQ5ZWQtODgxYi0xYmJjZTU4MWFlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk3NDg0MTAsImV4cCI6MTYwMDM1MzIxMH0.fOxjDAF6mPQyiPrETO-_R0HOJk37iJ6x6aStJHa4TqfwXfeqMMfbujei2Gi7NACxI6ITrhvqN3XqqXguPHePPA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "customerKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @ccUpdatePhoneNumberByAgentStatus404
  Scenario Outline: CC Edit Phone Number by Agent - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjM4NzNjMy1hZmMxLTQ5ZWQtODgxYi0xYmJjZTU4MWFlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk3NDg0MTAsImV4cCI6MTYwMDM1MzIxMH0.fOxjDAF6mPQyiPrETO-_R0HOJk37iJ6x6aStJHa4TqfwXfeqMMfbujei2Gi7NACxI6ITrhvqN3XqqXguPHePPA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  @ccUpdatePhoneNumberByAgentStatus400
  Scenario Outline: CC Edit Phone Number by Agent - Phone Number Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjM4NzNjMy1hZmMxLTQ5ZWQtODgxYi0xYmJjZTU4MWFlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk3NDg0MTAsImV4cCI6MTYwMDM1MzIxMH0.fOxjDAF6mPQyiPrETO-_R0HOJk37iJ6x6aStJHa4TqfwXfeqMMfbujei2Gi7NACxI6ITrhvqN3XqqXguPHePPA"
    And I set header "customerKey" parameter with value "754d229b-989e-4144-92fb-e1cb75d3a9af"
    And I set request body with information given in the following table
      | phone | <phoneValue> |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "phone" for key "errors[0].field"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"

    Examples:
      | phoneValue    |
      |               |
      | 441           |
      | 4412345678900 |
      | 123456789012  |
      | 44qwertyuiop  |
      | qwertyuriopp  |


  # Customer: reading66@yopmail.com
  @ccUpdatePhoneNumberByAgentStatus409
  Scenario Outline: CC Edit Phone Number by Agent - Phone Already Exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlNjM4NzNjMy1hZmMxLTQ5ZWQtODgxYi0xYmJjZTU4MWFlNzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk3NDg0MTAsImV4cCI6MTYwMDM1MzIxMH0.fOxjDAF6mPQyiPrETO-_R0HOJk37iJ6x6aStJHa4TqfwXfeqMMfbujei2Gi7NACxI6ITrhvqN3XqqXguPHePPA"
    And I set header "customerKey" parameter with value "4d6fe519-7b2e-4f73-aa28-72530fb778eb"
    And I set request body with information given in the following table
      | phone | <phoneValue> |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 409
    And response body should contain value of "65010" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same phone number. Please call Contact Centre for further questions" for key "errors[0].description"

    Examples:
      | phoneValue   |
      | 444897846532 |
      | 447946349829 |


  ## Onboarding Status: EMAIL_CAPTURED, EMAIL_VERIFIED, NAME_DOB_CAPTURED, TELEPHONE_CAPTURED
  @ccUpdatePhoneNumberByAgentStatus400
  Scenario Outline: CC Edit Phone Number by Agent - Onboarding Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | c0ad2bc9-bc94-4c1d-b5bb-90dbaf5bf683 |
      | 93daeaae-b6e6-4430-91fe-c6c272c6589f |
      | 8a307f49-7a77-47d2-9644-e941dd666428 |
      | 62313675-b176-4afb-9395-a3dbccce5658 |


  ## Customer Status: FRAUD, DELETED, SUSPEND
  @ccUpdatePhoneNumberByAgentStatus400
  Scenario Outline: CC Edit Phone Number by Agent - Customer Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | phone | 441122334455 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 400
    And response body should contain value of "65014" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | dd750b32-e1f2-48e5-89c7-35bfbfad4c55 |
      | 4ce270ac-7018-496c-b0aa-75f76d8036a1 |
      | a2ade24b-eafe-4c1b-b64a-28b906b877b1 |


  @ccUpdatePhoneNumberByAgent_1
  Scenario: CC Edit Phone Number by Agent - Active Customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2NTJlMjRlZS0xZmZlLTQ1N2MtOWE1My1kOTE4ZGJiZmEzOTgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk4MTQ4NjgsImV4cCI6MTYwMDQxOTY2OH0.imMd7Gpwuf24NBkRUhYlS7KjxYVKXITmtEAVpXIKYLZEc7zskBB4fg0gb-NguWVbtDxyjWNlGJwzOad-8vvCqA"
    And I set header "customerKey" parameter with value "63a37a82-e4f0-4481-a624-368960f3ea4c"
    And I set request body with information given in the following table
      | phone | 445877566845 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 204


  @ccUpdatePhoneNumberByAgent_2
  Scenario: CC Edit Phone Number by Agent - Resend SMS Code
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2NTJlMjRlZS0xZmZlLTQ1N2MtOWE1My1kOTE4ZGJiZmEzOTgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk4MTQ4NjgsImV4cCI6MTYwMDQxOTY2OH0.imMd7Gpwuf24NBkRUhYlS7KjxYVKXITmtEAVpXIKYLZEc7zskBB4fg0gb-NguWVbtDxyjWNlGJwzOad-8vvCqA"
    And I set header "customerKey" parameter with value "63a37a82-e4f0-4481-a624-368960f3ea4c"
    And I set request body with information given in the following table
      | phone | 445877566845 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 204

  @verifyPhoneNumber
  Scenario: Verify Phone Number
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2NTJlMjRlZS0xZmZlLTQ1N2MtOWE1My1kOTE4ZGJiZmEzOTgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk4MTQ4NjgsImV4cCI6MTYwMDQxOTY2OH0.imMd7Gpwuf24NBkRUhYlS7KjxYVKXITmtEAVpXIKYLZEc7zskBB4fg0gb-NguWVbtDxyjWNlGJwzOad-8vvCqA"
    And I set query parameter "phone" with value "445877566845"
    And I set query parameter "code" with value "512146"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 200
    And response body should contain value of "REGISTRATION_COMPLETE" for key "onboardingStatus"
    And response body should contain value of "ACTIVE" for key "customerStatus"



  ## Manually get the SMS code from DB
  ## Customer's edited phone number has been verified by the agent


  @ccUpdatePhoneNumberByAgentStatus409
  Scenario: CC Edit Phone Number by Agent - New number is already requested for another customer
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2NTJlMjRlZS0xZmZlLTQ1N2MtOWE1My1kOTE4ZGJiZmEzOTgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudENhdCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTk4MTQ4NjgsImV4cCI6MTYwMDQxOTY2OH0.imMd7Gpwuf24NBkRUhYlS7KjxYVKXITmtEAVpXIKYLZEc7zskBB4fg0gb-NguWVbtDxyjWNlGJwzOad-8vvCqA"
    And I set header "customerKey" parameter with value "29cc288a-23f4-4167-97ee-cd5509eb5834"
    And I set request body with information given in the following table
      | phone | 445877566845 |
    When I PUT request to "/v1/customers/phone/agent"
    Then response status code should be 409
    And response body should contain value of "65018" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same phone number. Please call Contact Centre for further questions" for key "errors[0].description"
