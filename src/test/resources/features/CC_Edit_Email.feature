Feature: Contact Center - Edit Customer's Email

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"
    And I set request header content type as JSON


  @ccEditEmailStatus401
  Scenario Outline: CC Edit Email - Token Validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@asd.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @ccEditEmailStatus401
  Scenario: CC Edit Email - Expired Agent Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@asd.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @ccEditEmailStatus403
  Scenario: CC Edit Email - Customer Access Token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set header "customerKey" parameter with value "e2da6d88-c757-4a0d-88bb-931858b43f99"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"


  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email - customerKey Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "customerKey" for key "errors[0].field"
    And response body should contain value of "length must be 36" for key "errors[0].description"

    Examples:
      | keyValue                              |
      |                                       |
      | 123                                   |
      | dummyKeydummyKeydummyKeydummyKeydummy |


  @ccEditEmailStatus404
  Scenario Outline: CC Edit Email - Customer Not Found
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<keyValue>"
    And I set request body with information given in the following table
      | email | asd@assfsfd.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 404
    And response body should contain value of "65011" for key "errors[0].code"
    And response body should contain value of "Customer not found with key: <keyValue>" for key "errors[0].description"

    Examples:
      | keyValue                             |
      | dummyKeydummyKeydummyKeydummyKeydumm |
      | a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5 |


  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email - Email Validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "fafd64b8-9b70-48fe-960e-7051f3ed7b77"
    And I set request body with information given in the following table
      | email | <emailValue> |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | emailValue                                          | fieldName | message                             |
      | sdfhghg                                             | email     | must be a well-formed email address |
      |                                                     | email     | size must be between 6 and 50       |
      | a@b.c                                               | email     | size must be between 6 and 50       |
      | fsfkhsjfkhsjadfsdfsfkhsjfkhssdfsfkfkhsj@bfsfsdf.com | email     | size must be between 6 and 50       |


  # Customer: onb_happy_path_4@hymnai.com
  # Try to change the email address as 'onb_email_captured@hymnai.com' or 'onb_happy_path_5@hymnai.com' which are already existed
  # When customer tries to update their email address with the same one, we return the same error
  @ccEditEmailStatus409
  Scenario Outline: CC Edit Email - Email already exists
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "fafd64b8-9b70-48fe-960e-7051f3ed7b77"
    And I set request body with information given in the following table
      | email | <emailValue> |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 409
    And response body should contain value of "65016" for key "errors[0].code"
    And response body should contain value of "Email already exists" for key "errors[0].description"

    Examples:
      | emailValue                    |
      | onb_email_captured@hymnai.com |
      | onb_happy_path_5@hymnai.com   |
      | onb_happy_path_4@hymnai.com   |


  ## Onboarding Status: EMAIL_CAPTURED, EMAIL_VERIFIED, NAME_DOB_CAPTURED, TELEPHONE_CAPTURED
  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email - Onboarding Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | email | wrongStatus@hymnai.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | 627b5b6e-5f4e-467d-859f-be82c7700553 |
      | 45553bd5-9781-451f-bdac-bcf7ecb6e03c |
      | d2b8c073-8915-4469-b74f-571fe958a35a |
      | 3ea117dd-ef3a-4948-8291-d777a5ee4d63 |


  ## Customer Status: FRAUD, DELETED, SUSPEND
  @ccEditEmailStatus400
  Scenario Outline: CC Edit Email - Customer Status Control
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set header "customerKey" parameter with value "<customerKeyValue>"
    And I set request body with information given in the following table
      | email | wrongStatus@hymnai.com |
    When I PUT request to "/v1/customers/email"
    Then response status code should be 400
    And response body should contain value of "65014" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"

    Examples:
      | customerKeyValue                     |
      | ba23e57b-66f7-4a5d-afae-2c8d24768996 |
      | 30ea2993-3c05-45de-a7c0-f469e05e7886 |
      | 39cce278-c9c4-4b89-a62a-04797c885408 |

