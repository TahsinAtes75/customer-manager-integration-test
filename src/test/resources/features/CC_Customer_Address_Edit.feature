Feature: CC - Edit Customer Address

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"
    And I set request header content type as JSON


  @editAddressStatus401
  Scenario Outline: Edit Address - Access token validation
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | UK                |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @editAddressStatus400
  Scenario Outline: Edit Address - addressKey validation
    And I set path parameter "addressKey" with value "<addressKeyValue>"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK                |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"
    And response body should contain value of "addressKey" for key "errors[0].field"

    Examples:
      | addressKeyValue                       | message           |
      | asd                                   | length must be 36 |
      | sdfsdfsdf_sdfsdfsd_asfdsadfsda_sdfsdf | length must be 36 |


  @editAddressStatus500
  Scenario: Edit Address - empty addressKey validation
    And I set path parameter "addressKey" with value ""
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK                |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 500


  @editAddressStatus400
  Scenario Outline: Edit Address - Country Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4ZmM2ODcxNS0zNzY5LTQ1NDQtOWI5OS0wYzJkNTZkYWI1MjYiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAxMzc2MjksImV4cCI6MTg5NTk4MjY0Mn0.cUbW4miLgJLfTl7eTtTjNTrAM5j1Jg8hmJm6jJGj7NFfYFRzFwlW0glKzAnhAMm6_TCRp6eI_5moVJ46L-8r3g"
    And I set request body with information given in the following table
      | country  | <countryValue>    |
      | county   |                   |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | countryValue                                        | fieldName | message                       |
      |                                                     | country   | size must be between 1 and 50 |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom | country   | size must be between 1 and 50 |


  @editAddressStatus400
  Scenario Outline: Edit Address - County Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK                |
      | county   | <countyValue>     |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | countyValue                          | fieldName | message                       |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkf | county    | size must be between 0 and 35 |


  @editAddressStatus400
  Scenario Outline: Edit Address - Line1 Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK           |
      | county   | Berkshire    |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line1Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      |                                                                                                                                                                                                                                                                  | line1     | size must be between 1 and 255 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line1     | size must be between 1 and 255 |


  @editAddressStatus400
  Scenario Outline: Edit Address - Line2 Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    | <line2Value>   |
      | postCode | RG1 7EB        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line2Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line2     | size must be between 0 and 255 |


  @editAddressStatus400
  Scenario Outline: Edit Address - postCode Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK              |
      | county   | Berkshire       |
      | line1    | 3 Queen's Road  |
      | line2    |                 |
      | postCode | <postCodeValue> |
      | town     | Reading         |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | postCodeValue | fieldName | message                      |
      |               | postCode  | size must be between 1 and 8 |
      | fsdfsfsfa     | postCode  | size must be between 1 and 8 |


  @editAddressStatus400
  Scenario Outline: Edit Address - town Validation Test
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | <townValue>    |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | townValue                            | fieldName | message                       |
      |                                      | town      | size must be between 1 and 35 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa s | town      | size must be between 1 and 35 |


  @editAddressStatus200
  Scenario: Edit Address - Happy Path
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   |                |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_4@hymnai.com",
      "line1": "${json-unit.ignore}",
      "line2": "${json-unit.ignore}",
      "town": "${json-unit.ignore}",
      "county": "${json-unit.ignore}",
      "country": "${json-unit.ignore}",
      "postCode": "${json-unit.ignore}",
      "onboardingStatus": "${json-unit.ignore}",
      "customerStatus": "${json-unit.ignore}"
    }
    """


  @editAddressStatus404
  Scenario: Edit Address - addressKey Not Found
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a1"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 404
    And response body should contain value of "65015" for key "errors[0].code"
    And response body should contain value of "Address not found with key: c81f745b-fb91-4fad-a298-fdb4aaa287a1" for key "errors[0].description"


  @editAddressStatus401
  Scenario: Edit Address - Expired Agent Access Token
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4NTU3ZWU0OC02MWQwLTQ1NDQtOWUxZi02NTE2NmNlZDY4OGQiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODAyMTEwMjcsImV4cCI6MTU4MDM2MzQ0Mn0.cJD26vXwTtuQwaT7WgZi0ED2GtGbr8ZxcDMjSu9AwHdOI9EYEvutgD9aSCjDbtPyGlV7BsNutE56KtwMmW-GkA"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @editAddressStatus403
  Scenario: Edit Address - Customer Access Token
    And I set path parameter "addressKey" with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmMDYzNTIxOS1kNWQ0LTRmMjctYTk0MS0xZGYxOTJiZmZlM2YiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTgwNDA2NDI2LCJleHAiOjE4OTU5ODI2NDJ9.Kh0pdljjYkGsVccBKz3Bdb5I1jCh0ZJwaBw-eek9XLTTQhqVO9dNekneSp2rP17LSJxIi3eynLZIL8avIpQrtQ"
    And I set request body with information given in the following table
      | country  | UK             |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses/{addressKey}"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
