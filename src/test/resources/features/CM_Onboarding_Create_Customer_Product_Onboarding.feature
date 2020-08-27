Feature: Customer Manager - Onboarding Service - Create Customer Product Onboarding

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON


  @createCustomerProductOnboardingStatus401
  Scenario Outline: Create Customer Product Onboarding - Customer token validation
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                          |
      |                                                                                                                                                                                                                                                                                     |
      | asd                                                                                                                                                                                                                                                                                 |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A  |


  @createCustomerProductOnboardingStatus401
  Scenario: Create Customer Product Onboarding - Agent token validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZWNlMWMyYi1hM2IwLTQzNmYtYTIyMi1hNGI4ZGExOWEyMTciLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJQSTRhZ2VudCIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTgyOTIyNTcsImV4cCI6MTU5ODg5NzA1N30._mCJOwrjYLouWd0H-4k09UiTMRsv_3eGeBRP-YCBs2eHFuP0aRp0Xuo4tkRNItIEGlpBZrVjq5d9cKviqD8QCQ"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

  ##
  #Manually get the customer token value from "/v1/customers/onboarding" API
  #440087352789 is belong to customer:kafkatest@yopmail.com
  ##
  @createCustomerProductOnboardingStatus409
  Scenario: Create Customer Product Onboarding - Phone Number Already Exists Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhYjA5ZWZlZi0xNzZkLTQzZmYtOTZmZi0zMmZlNTJhMmYyZTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyOWFjOWYwZi00OWEyLTQ2ODMtOGM0Mi00NDBiNGNhZmFhYTIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NTI5NTg1LCJleHAiOjE1OTkxMzQzODV9.KOfVZNUnbFDHeU4IZ3g4nW5uZcK3VOo19pdmF_KT6gT_PPOQvxmsUcbTD54hVHl54nyFuTUxfmmlKTNP2vG-0A"
    And I set request body with information given in the following json
 """
 {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 440087352789,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 409
    And response body should contain value of "65010" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same phone number. Please call Contact Centre for further questions" for key "errors[0].description"

  ##
  # Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  ##
  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Invalid Phone Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZTAyZWUxNy1kM2NiLTQ0ODQtYTcyOS0yNTc2NTNlYWMwNjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhYzllNDZhMi1kYjhiLTQ5OGYtYjQyOS04Y2Y0ZWRmYjNlNWIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NDcyMDc5LCJleHAiOjE1OTkwNzY4Nzl9.P5znXyRJve7msUG3nSpApCtHgvhqNM_WS2BQtlplWFEJQvkjCZ6wmVPIck3YDt432xHaCtaqMq2_GlJUa0DEDA"
    And I set request body with information given in the following json
 """
 {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": "<phoneValue>",
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"

    Examples:
      | phoneValue    |
      |               |
      | 441           |
      | 4412345678900 |
      | 123456789012  |
      | 44qwertyuiop  |
      | qwertyuriopp  |

  ##
  # Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  ##
  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Postcode Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZTAyZWUxNy1kM2NiLTQ0ODQtYTcyOS0yNTc2NTNlYWMwNjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhYzllNDZhMi1kYjhiLTQ5OGYtYjQyOS04Y2Y0ZWRmYjNlNWIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NDcyMDc5LCJleHAiOjE1OTkwNzY4Nzl9.P5znXyRJve7msUG3nSpApCtHgvhqNM_WS2BQtlplWFEJQvkjCZ6wmVPIck3YDt432xHaCtaqMq2_GlJUa0DEDA"
    And I set request body with information given in the following json
 """
 {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "<postCodeValue>",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | postCodeValue | fieldName             | message                      |
      |               | addresses[0].postCode | size must be between 1 and 8 |
      | fsdfsfsfa     | addresses[0].postCode | size must be between 1 and 8 |

  ##
  # Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  ##

  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Date of Birth Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZTAyZWUxNy1kM2NiLTQ0ODQtYTcyOS0yNTc2NTNlYWMwNjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhYzllNDZhMi1kYjhiLTQ5OGYtYjQyOS04Y2Y0ZWRmYjNlNWIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NDcyMDc5LCJleHAiOjE1OTkwNzY4Nzl9.P5znXyRJve7msUG3nSpApCtHgvhqNM_WS2BQtlplWFEJQvkjCZ6wmVPIck3YDt432xHaCtaqMq2_GlJUa0DEDA"
    And I set request body with information given in the following json
 """
 {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "<dateOfBirthValue>",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Http Message Not Readable" for key "errors[0].description"

    Examples:
      | dateOfBirthValue|
      | asdf            |
      | 1980            |
      | 1980-11         |
      | 1980-13-01      |
      | 1980-112-01     |
      | 1980-1-01       |
      | 1980-12-32      |
      | 1983-01-123     |
      | 1983-01-1       |
      | 1983-02-29      |
      | 1983-04-31      |

  ## Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API

  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Date of Birth Rules Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2ZTAyZWUxNy1kM2NiLTQ0ODQtYTcyOS0yNTc2NTNlYWMwNjEiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJhYzllNDZhMi1kYjhiLTQ5OGYtYjQyOS04Y2Y0ZWRmYjNlNWIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NDcyMDc5LCJleHAiOjE1OTkwNzY4Nzl9.P5znXyRJve7msUG3nSpApCtHgvhqNM_WS2BQtlplWFEJQvkjCZ6wmVPIck3YDt432xHaCtaqMq2_GlJUa0DEDA"
    And I set request body with information given in the following json
 """
 {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "<dateOfBirthValue>",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65000" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | dateOfBirthValue | fieldName             | message                              |
      |                  | profile.dateOfBirth   | Date can not be empty                |
      | 1898-11-15       | profile.dateOfBirth   | Age must be 120 years old or younger |
      | 2030-01-01       | profile.dateOfBirth   | Date can not be a future date        |
      | 2010-01-01       | profile.dateOfBirth   | Age must be 18 years old or older    |

## Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API

  @createCustomerProductOnboardingStatus401
  Scenario Outline: Create Customer Product Onboarding - Customer Onboarding Status Validation Test
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                                                                       |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzNTQ0ZTVhYi0yNjhmLTRjNGUtYjRlMy1kM2I0MTAwZjdjZTkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJiMWJmNTZiYi1mOTMyLTQyZTEtYWMxZC1jNTEzMmY2OWMxODIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4MzQ2MzY5LCJleHAiOjE1OTg5NTExNjl9.qM2-G--KhsPIcOPg23_JME5wq7ZR1BvB_5rsJFsIWDPJCbY3FX-tpUMyreJaofcFPNggShyu7tY03TLnaTAyHA |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3NDQyZjQxNy1lOWMxLTRlN2YtYWM1Ny04ZmE0MTFlNWUxZjgiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjYTE3ZGEyMi1lYmE0LTQ4MmMtOGIwOS01YjYzOGY0NTNkYzEiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4MzQ3MTU3LCJleHAiOjE1OTg5NTE5NTd9.HQXtKpJI8AnaZAHKMRyH0fNkN31rYSJM_1dFPQgbEqpHTawGwyqAxY2VcaaHCwdLHcLgA2dO4jf67Ogs8oQD1w |


#customer1: newonbr90@yopmail.com     onboarding status:PASSCODE_CAPTURED
#customer2: creditonbr8@yopmail.com   onboarding status:EMAIL_CAPTURED


  ## Manually get the customer token value from "/v1/tokens/customer/onboarding" API

  @createCustomerProductOnboardingStatus401
  Scenario Outline: Create Customer Product Onboarding - Active Customer Validation Test
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334455,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65014" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                                                                       |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJlYTQzYmMwMS0wZTI5LTRiZjQtOGI1YS1lMjU2MTNmZTcxM2EiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyNWM1MDI1YS00NGMzLTQ0N2MtYmNlNy1lN2U5MjIwM2UzNjIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4MzQ3NTc0LCJleHAiOjE1OTg5NTIzNzR9.mSJ3MYDGf0YtN_ZkOwhItI2KX92kfCBaLO0Ny7lldMIB8d7zqv15sX4EEe9P4uEu9cFyh7CymYlcYI9PjIIK-w |

#customer: test77@yopmail.com        onboarding status:Registiration_complete


  # Onboarding status is EMAIL_CAPTURED
  # Customer: cardtest22@yopmail.com
  # Customer token has been taken without verifying the email
  @createCustomerProductOnboardingStatus400
  Scenario: Create Customer Product Onboarding - Email is not verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmZmMwODQwMi05ZTg4LTQ4MjMtYjgzYi1mOGVlMGE5OTJlN2YiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYjY1ZTYyMC1mNzA5LTQ5ZDQtOWQwYi03ZmVmNzNhYjE5NzAiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NTMwMzk1LCJleHAiOjE1OTkxMzUxOTV9._nsQ7J0alUGe-1GNQayTis7frJ78WNDVl9JT2CWc8j2bYt9tQ8uSCw0x10M-Nvijvpuad93CsLH73gWNx4rOuQ"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 441122334450,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65009" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"


  @createCustomerProductOnboardingStatus204
  Scenario: Create Customer Product Onboarding - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjNmVjM2U2Ny02NWE2LTRlYjgtOGI4OS04NDg5MTY3YjZiNDMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI3OTM5OGVhYi0zZTM0LTRlNjItOTA3My1hODc1N2U0YWNiNGMiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk4NTMxOTgxLCJleHAiOjE1OTkxMzY3ODF9.UNDy1iViNJ3wWnqPZr0Om6_GBlQVEDUhHP09knUjZ25BRR5Bd6atl6V2p3mPFeFZ3ShlwdeK0nszaV0gBcbFbg"
    And I set request body with information given in the following json
    """
  {
  "addresses": [
    {
      "country": "GBR",
      "county": "Surrey",
      "line1": "Kingston wood street",
      "line2": "",
      "postCode": "KT11TG",
      "residentialStatus": "HOME_OWNER",
      "status": "ACTIVE",
      "timeAtAddress": {
        "months": 1,
        "years": 2
      },
      "town": "Kingston"
    }
  ],
  "phone": 440022334450,
  "profile": {
    "dateOfBirth": "1980-04-26",
    "givenNames": "John",
    "preferredName": "Smith",
    "surname": "Doe"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 204

