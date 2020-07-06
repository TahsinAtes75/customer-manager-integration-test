Feature: CM - Update Address for Customer

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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
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

  @updateAddressStatus400
  Scenario: Update Address - empty addressKey validation
    And I set header "addressKey" parameter with value ""
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | Berkshire         |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
   Then response status code should be 400

  @updateAddressStatus400
  Scenario: Update Address - County Validation Test
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR               |
      | county   | fsfkhsjfkhsjadfsdfsfkh sjfkhssdfsfkf |
      | line1    | 40 Caversham Road |
      | line2    |                   |
      | postCode | RG1 7EB           |
      | town     | Reading           |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "county" for key "errors[0].field"
    And response body should contain value of "size must be between 0 and 35" for key "errors[0].description"

  @updateAddressStatus400
  Scenario Outline: Update Address - Line1 Validation Test
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR          |
      | county   | Berkshire    |
      | line1    | <line1Value> |
      | line2    |              |
      | postCode | RG1 7EB      |
      | town     | Reading      |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | line1Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      |                                                                                                                                                                                                                                                                  | line1     | size must be between 1 and 255 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line1     | size must be between 1 and 255 |

  @updateAddressStatus400
  Scenario Outline: Update Address - Line2 Validation Test
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    | <line2Value>   |
      | postCode | RG1 7EB        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | line2Value                                                                                                                                                                                                                                                       | fieldName | message                        |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa sfdsfsdfsfsfs fsdfsfsfsdf | line2     | size must be between 0 and 255 |


  @editAddressStatus400
  Scenario Outline: Edit Address - postCode Validation Test
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR             |
      | county   | Berkshire       |
      | line1    | 3 Queen's Road  |
      | line2    |                 |
      | postCode | <postCodeValue> |
      | town     | Reading         |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | postCodeValue | fieldName | message                      |
      |               | postCode  | size must be between 1 and 8 |
      | fsdfsfsfa     | postCode  | size must be between 1 and 8 |

  @updateAddressStatus400
  Scenario Outline: Update Address - town Validation Test
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   | Berkshire      |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | <townValue>    |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | townValue                            | fieldName | message                       |
      |                                      | town      | size must be between 1 and 35 |
      | sfsdfsdfsf dfsdfsdfsf sfsfsfadsdsa s | town      | size must be between 1 and 35 |

  @updateAddressStatus200
  Scenario: Update Address - Happy Path
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
    And I set request body with information given in the following table
      | country  | GBR            |
      | county   |                |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AR        |
      | town     | Reading        |
    When I PUT request to "/v1/customers/addresses"
    Then response status code should be 204

  @updateAddressStatus404
  Scenario: Update Address - addressKey Not Found
    And I set header "addressKey" parameter with value "c81f745b-fb91-4fad-a298-fdb4aaa287a2"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDVmOGVlMi1kMDIwLTRiNzMtYmRmOS00NzZhYjY4M2E1YzEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmOGE1MTA1Ny03MTJlLTQwZWUtODE1Yy1lZjEyMTk4ZTQxZjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTkzNTMxNTcxLCJleHAiOjE1OTQxMzYzNzF9.sSooR7HAAVI48Dma8i2QeET8iVuex_CXVuu8yIVYI3eodAy_gU1yzcpGWaPqKVUHWWOrat6bO3yQ-5FWoaY4CA"
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

  @updateAddressStatus401
  Scenario: Update Address - Expired Customer Access Token
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
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

  @updateAddressStatus403
  Scenario: Edit Address - Agent Access Token
    And I set header "addressKey" parameter with value "e58e5815-3854-47d2-a7cf-dc4a6f25279a"
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0OTQzZWYwYi0zMDZlLTRiMGUtODE1Zi01MzRmZDY1MmRiZTYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZW1vYWdlbnQiLCJzY29wZSI6IkFHRU5UIiwiaWF0IjoxNTkzNTQyNzM0LCJleHAiOjE1OTQxNDc1MzR9.-Nc3mRsQwJXTgEjCZI5W5RB5mRurlovdE9nU9XOlwWONf3pXr5SfervAV0h5GlUY-nsMtLr4ZrnVkS-SN2RxTA"
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
