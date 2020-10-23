Feature: Customer Manager-Address Service - Update Address for Customer

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @updateAddressStatus401
  Scenario Outline: Update Address - Access token validation
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
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


  @updateAddressStatus400
  Scenario Outline: Update Address - addressKey validation
    And I set header "addressKey" parameter with value "<addressKeyValue>"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<message>" for key "errors[0].description"
    And response body should contain value of "addressKey" for key "errors[0].field"

    Examples:
      | addressKeyValue                       | message           |
      | asr                                   | length must be 36 |
      | sdfsdfsdf_sdfsdfsd_asfdsadfsda_sdfsdf | length must be 36 |

  @updateAddressStatus400
  Scenario: Update Address - empty addressKey validation
    And I set header "addressKey" parameter with value ""
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
   Then response status code should be 400

  @updateAddressStatus400
  Scenario: Update Address - County Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR                                  |
      | county   | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkf |
      | line1    | 40 Caversham Road                    |
      | line2    |                                      |
      | postCode | RG1 7EB                              |
      | status   | ACTIVE                               |
      | town     | Reading                              |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "county" for key "errors[0].field"
    And response body should contain value of "size must be between 0 and 35" for key "errors[0].description"

  @updateAddressStatus400
  Scenario Outline: Update Address - Line1 Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR          |
      | county   | Berkshire    |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | status   | ACTIVE       |
      | town     | Reading      |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | line1Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      |                                                                                                                                                                                                                                                                  | line1     | size must be between 1 and 255 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line1     | size must be between 1 and 255 |

  @updateAddressStatus400
  Scenario Outline: Update Address - Line2 Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |   <line2Value>    |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | line2Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line2     | size must be between 0 and 255 |


  @editAddressStatus400
  Scenario Outline: Edit Address - postCode Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | <postCodeValue>   |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | postCodeValue | fieldName | message                      |
      |               | postCode  | size must be between 1 and 8 |
      | fsdfsfsfa     | postCode  | size must be between 1 and 8 |

  @updateAddressStatus400
  Scenario Outline: Update Address - town Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | <townValue>       |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | townValue                            | fieldName | message                       |
      |                                      | town      | size must be between 1 and 35 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa s | town      | size must be between 1 and 35 |

  @updateAddressStatus200
  Scenario: Update Address - Happy Path
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 204

  @updateAddressStatus404
  Scenario: Update Address - addressKey Not Found
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 404
    And response body should contain value of "65301" for key "errors[0].code"
    And response body should contain value of "Address not found with key: c81f745b-fb91-4fad-a298-fdb4aaa287a2" for key "errors[0].description"

  @updateAddressStatus401
  Scenario: Update Address - Expired Customer Access Token
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkNzk0ZTFmYS01NWIzLTRiZTItYjkwZS1iZWRkOGM1YzRlNGEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIzZmQ3MzNlMi0wNTNlLTRlYzUtYWIxNi1kZDQzNjVjOTY5MjkiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkxMzcwODMzLCJleHAiOjE1OTE5NzU2MzN9.o1ZxID33NXiYZiUgTixb4KNxUwPmlmfgwEcN_KRtdOhQO98XQP9QXLOlKE4m89TjJJs-yhqHw2HUU5rdFhGokQ"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

  @updateAddressStatus403
  Scenario: Edit Address - Agent Access Token
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxYTZkYWEzZC0zZTcwLTQwMzgtODQyNS01YTVlNWNiZDc1OWEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDMzODI5NzQsImV4cCI6MTYwMzk4Nzc3NH0.MvJVy8VyUquD1OvGEJ9nOnJa9EplVqEtJEN_tNmPoxAZFldW4f2WAdCSNB12yuOJg_DgBv-QedpRYsau-LChPQ"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | ACTIVE            |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 403
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Method access denied" for key "errors[0].description"

  @updateAddressStatus400
  Scenario Outline: Edit Address - Status Validation Test
    And I set header "addressKey" parameter with value "982fa37e-8087-43cc-84f7-726c1f1dbbb4"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzM5YmM5OC04MmQ0LTQ0M2QtYjkzOS1lMzY1MTBjYTI2ZTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzgxMzMyLCJleHAiOjE2MDM5ODYxMzJ9.__7x5bFksgvslbyh3W_4nVsDAXyJH7C2d4ob4-a1I2Yp6GCRSScY7eRX5W5rQ83aJavqNNgOAvK4wKXk2Dj8tw"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | status   | <statusValue>     |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65001" for key "errors[0].code"
    And response body should contain value of "HTTP Message Not Readable" for key "errors[0].description"
    Examples:
      | statusValue |
      | ACTI        |
      | PASVE       |