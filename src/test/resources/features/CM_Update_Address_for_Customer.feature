Feature: CM - Update Address for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @updateAddressStatus401 #ok
  Scenario Outline: Update Address - Access token validation
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asr                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |


  @updateAddressStatus400 #ok
  Scenario Outline: Update Address - addressKey validation
    And I set header "addressKey" parameter with value "<addressKeyValue>"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"
    And response body should contain value of "addressKey" for key "errors[0].field"

    Examples:
      | addressKeyValue                       | message           |
      | asr                                   | length must be 36 |
      | sdfsdfsdf_sdfsdfsd_asfdsadfsda_sdfsdf | length must be 36 |


  @updateAddressStatus500  #ok
  Scenario: Update Address - empty addressKey validation
    And I set header "addressKey" parameter with value ""
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
   Then response status code should be 400


  @UPDATEAddressStatus400   #TEKRAR BAK SORUN VAR
  Scenario Outline: Update Address - Country Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | <countryValue>    |
      | county   |                   |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "country" for key "validationErrors[0].field"
    And response body should contain value of "code is not acceptable" for key "validationErrors[0].message"

    Examples:
      | countryValue                                        |
      |                                                     |
      | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkfkhs jbfsfsdfcom |
      | United Kingdom                                      |
      | ASD                                                 |
      | 123                                                 |
      | UK                                                  |
      | AB?                                                 |
      | GB                                                  |
      | 826                                                 |


  @updateAddressStatus400
  Scenario: Update Address - County Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | <countyValue>     |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "size must be between 0 and 35" for key "errors[0].description"




  @updateAddressStatus400
  Scenario Outline: Update Address - Line1 Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR          |
      | county   | Berkshire    |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line1Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      |                                                                                                                                                                                                                                                                  | line1     | size must be between 1 and 255 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line1     | size must be between 1 and 255 |


  @updateAddressStatus400
  Scenario Outline: Update Address - Line2 Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    | <line2Value>   |
      | postCode | RG1 7EB        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | line2Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line2     | size must be between 0 and 255 |


  @updateAddressStatus400
  Scenario Outline: Update Address - postCode Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | GBR             |
      | county   | Berkshire       |
      | line1    | 3 Queen's Road  |
      | line2    |                 |
      | postCode | <postCodeValue> |
      | town     | Reading         |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should be following json
    """
    xyz

    """
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].message"

    Examples:
      | postCodeValue | fieldName | message                      |
      |               | postCode  | size must be between 1 and 8 |
      | fsdfsfsfa     | postCode  | size must be between 1 and 8 |

#-----------------------------------
  @updateAddressStatus400
  Scenario Outline: Update Address - postCode Validation Test
    Given I set REST API url as "https://customer-manager.test.heymanai.com/"
    And I set request header content type as JSON
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | <postCode>     |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should be following json
  """
  {
    "errors": [
      {
        "code": "65000",
        "description": "<description>",
        "field": "<field>"
      }
    ]
  }
  """
    Examples:
      | postCode  | description                  | field    |
      | fsdfsfsfa | size must be between 1 and 8 | postCode |
      | jhv       | size must be between 1 and 8 | postCode |
      | 876       | size must be between 1 and 8 | postCode |

















  @updateAddressStatus400
  Scenario Outline: Update Address - town Validation Test
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudEVicnUiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTgwMzk5NTg4LCJleHAiOjE4OTU5ODI2NDJ9._Y3wtRJPD0RFAXzxipz3HwXQLypSpwyjrKr1Wt1LD-UuJ0AiN0BOmjPvnXwRBfi24ZMOjDvUwF60JNUmKxMLdA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | <townValue>    |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "code"
    And response body should contain value of "<fieldName>" for key "validationErrors[0].field"
    And response body should contain value of "<message>" for key "validationErrors[0].message"

    Examples:
      | townValue                            | fieldName | message                       |
      |                                      | town      | size must be between 1 and 35 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa s | town      | size must be between 1 and 35 |


  @updateAddressStatus200
  Scenario: Update Address - Happy Path
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   |                |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_4@hymnai.com",
      "line1": "${json-unit.ignore}",
      "line2": "${json-unit.ignore}",
      "town": "${json-unit.ignore}",
      "county": "${json-unit.ignore}",
      "country": "GBR",
      "postCode": "${json-unit.ignore}",
      "onboardingStatus": "${json-unit.ignore}",
      "customerStatus": "${json-unit.ignore}"
    }
    """



  @updateAddressStatus404  #OK
  Scenario: Update Address - addressKey Not Found
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIwZDZmMTNkZS1jNTIxLTRkMmUtYmI2Mi1mZTdkYzgyYjUzMWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkyMzQxMTEzLCJleHAiOjE1OTI5NDU5MTN9.bcufpTxaMVEVc1vcIxe2WYAzWONdgICSRNjULl0WoejqPjrt8jCMQqzZXD9cFav8d6Ekop0SB57FEpwq9q9I8w"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 404
    And response body should contain value of "65015" for key "errors[0].code"
    And response body should contain value of "Address not found with key: c81f745b-fb91-4fad-a298-fdb4aaa287a2" for key "errors[0].description"


  @updateAddressStatus401 # OK
  Scenario: Update Address - Expired Customer Access Token
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkNzk0ZTFmYS01NWIzLTRiZTItYjkwZS1iZWRkOGM1YzRlNGEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkxMzcwODMzLCJleHAiOjE1OTE5NzU2MzN9.o1ZxID33NXiYZiUgTixb4KNxUwPmlmfgwEcN_KRtdOhQO98XQP9QXLOlKE4m89TjJJs-yhqHw2HUU5rdFhGokQ"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"


  @updateAddressStatus403   #OK
  Scenario: Update Address - Agent Access Token
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYmIzNzhhNi0zNTgxLTRjZjEtOWFiZS0yMzA2MGJjZDBlMzAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJ1c2VydXNlciIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTE4OTY2NjIsImV4cCI6MTU5MjUwMTQ2Mn0.r1cejaNx5uu5qT3-gPae0OO-bLVtYorfCy5GW7OZ7X_Vd1jNsvx7MZe8H4BOfzqhd5HuC_ryK3uMrB20C5VSJg"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
