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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
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


  @createCustomerProductOnboardingStatus403
  Scenario: Create Customer Product Onboarding - Agent token validation
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJjMDViYjhiNi00NjZjLTQyNjAtOGJkYi04NDVkYmE1OTI3MGIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJteWFnZW50MiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE2MDMzMTE1MDAsImV4cCI6MTYwMzkxNjMwMH0.VWw_g8lVC4Gk4RFtgYk95OVdkxqAWrc4CM7pUUBIMYmtvxnKPNt7bDukW_MUYoOcvB6BiuW8NeiL1LrZi2INzg"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 403
    And response body should contain value of "65004" for key "errors[0].code"
    And response body should contain value of "Method access denied" for key "errors[0].description"

  ##
  #Manually get the customer token value from "/v1/customers/onboarding" API
  #440087352789 is belong to customer:kafkatest@yopmail.com
  ##
  @createCustomerProductOnboardingStatus409
  Scenario: Create Customer Product Onboarding - Phone Number Already Exists Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDcwZmIyOS00MDE5LTQ3NjAtYmE3NC1kYzdlNjcyM2QwYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEwOTM4LCJleHAiOjE2MDM5MTU3Mzh9.tX8LzzwZdSagTfuQK0bNgGXkOwjGOyrTQNEo_9KewBeJfoUfVF73BjjRwlxSi0TVp6eRtNgIoxNhuhYzANZd8Q"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 440087352789,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 409
    And response body should contain value of "65400" for key "errors[0].code"
    And response body should contain value of "There is another customer recorded with the same phone number. Please call Contact Centre for further questions" for key "errors[0].description"

  ##
  # Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  ##
  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Invalid Phone Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDcwZmIyOS00MDE5LTQ3NjAtYmE3NC1kYzdlNjcyM2QwYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEwOTM4LCJleHAiOjE2MDM5MTU3Mzh9.tX8LzzwZdSagTfuQK0bNgGXkOwjGOyrTQNEo_9KewBeJfoUfVF73BjjRwlxSi0TVp6eRtNgIoxNhuhYzANZd8Q"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": <phoneValue>,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "Invalid phone number" for key "errors[0].description"

    Examples:
      | phoneValue    |
      | 441           |
      | 4412345678900 |
      | 123456789012  |


  ##
  # Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API
  ##
  @createCustomerProductOnboardingStatus400
  Scenario Outline: Create Customer Product Onboarding - Postcode Validation Test
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDcwZmIyOS00MDE5LTQ3NjAtYmE3NC1kYzdlNjcyM2QwYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEwOTM4LCJleHAiOjE2MDM5MTU3Mzh9.tX8LzzwZdSagTfuQK0bNgGXkOwjGOyrTQNEo_9KewBeJfoUfVF73BjjRwlxSi0TVp6eRtNgIoxNhuhYzANZd8Q"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDcwZmIyOS00MDE5LTQ3NjAtYmE3NC1kYzdlNjcyM2QwYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEwOTM4LCJleHAiOjE2MDM5MTU3Mzh9.tX8LzzwZdSagTfuQK0bNgGXkOwjGOyrTQNEo_9KewBeJfoUfVF73BjjRwlxSi0TVp6eRtNgIoxNhuhYzANZd8Q"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "<dateOfBirthValue>",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65001" for key "errors[0].code"
    And response body should contain value of "HTTP Message Not Readable" for key "errors[0].description"

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
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDcwZmIyOS00MDE5LTQ3NjAtYmE3NC1kYzdlNjcyM2QwYTMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEwOTM4LCJleHAiOjE2MDM5MTU3Mzh9.tX8LzzwZdSagTfuQK0bNgGXkOwjGOyrTQNEo_9KewBeJfoUfVF73BjjRwlxSi0TVp6eRtNgIoxNhuhYzANZd8Q"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "<dateOfBirthValue>",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
  """
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65005" for key "errors[0].code"
    And response body should contain value of "<fieldName>" for key "errors[0].field"
    And response body should contain value of "<message>" for key "errors[0].description"

    Examples:
      | dateOfBirthValue | fieldName             | message                              |
      |                  | profile.dateOfBirth   | Date can not be empty                |
      | 1898-11-15       | profile.dateOfBirth   | Age must be 120 years old or younger |
      | 2030-01-01       | profile.dateOfBirth   | Date can not be a future date        |
      | 2010-01-01       | profile.dateOfBirth   | Age must be 18 years old or older    |

## Manually get the onboarding token value from "/v1/tokens/customer/onboarding" API

  @createCustomerProductOnboardingStatus400
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65106" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                                                                       |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2MWVjMTJmZC1mYzFiLTRlNDktYjQ4Ny1hZGNmMzdiMjk5NDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjNDE1ZGNmMy00NTMzLTQ3ZTUtODVjMy00ZWJhYjIzYzZkNGIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEyODI5LCJleHAiOjE2MDM5MTc2Mjl9.y0Rl9vQ6r_yweT6wSU3rBUj-E1YX0J6q1IWwrS87yAl-IBMOp7Dzx4fLQClbQpjtQmvBvK7bQZY7YSiw3KViiQ |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ZDAyMzgwMy1lYTkyLTQ1NTMtODFlNS03MGQ1YzNkMWNjYWMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiIyMDljYjg2Ny04MGExLTQ1MWYtODk4MS04MjQ2MWE3MDExYWYiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEzMTg5LCJleHAiOjE2MDM5MTc5ODl9.N_njNbh4PCcL9UHywVfA_j6iLkBhFoJQCYfHyGf-pd2H4YaiqWmPOftU35Q-o5L-JwDGIfsHmLmnvSSEkwagUg |


#customer1: customerManager858@yopmail.com        onboarding status:EMAIL_CAPTURED
#customer2: 988_customerManager_524@yopmail.com   onboarding status:TELEPHONE_CAPTURED


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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65107" for key "errors[0].code"
    And response body should contain value of "Customer status is incompatible" for key "errors[0].description"

    Examples:
      | tokenValue                                                                                                                                                                                                                                                                                                                       |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkNTNlYTg5OC1mNWRmLTQwYWItYTc3YS0zMTBmOWQ1Zjc1OTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5Y2ViOWVjZi01ZmE1LTQ1NWItOTE4NC01NDcxNDIwYjQwZDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEzMzI2LCJleHAiOjE2MDM5MTgxMjZ9.Bpkdig8ZCsacYLK1GZhqZa4O6Z4jF7puya8VehnAVKvoCY6sICO9TlbvFKEHTqVdSP9tDS_0geJFf_ISI5OTPQ |

#customer: customerManager400@yopmail.com       onboarding status:Registiration_complete


  # Onboarding status is EMAIL_CAPTURED
  # Customer: customerManager858@yopmail.com
  # Customer token has been taken without verifying the email
  @createCustomerProductOnboardingStatus400
  Scenario: Create Customer Product Onboarding - Email is not verified
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI2MWVjMTJmZC1mYzFiLTRlNDktYjQ4Ny1hZGNmMzdiMjk5NDAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjNDE1ZGNmMy00NTMzLTQ3ZTUtODVjMy00ZWJhYjIzYzZkNGIiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEyODI5LCJleHAiOjE2MDM5MTc2Mjl9.y0Rl9vQ6r_yweT6wSU3rBUj-E1YX0J6q1IWwrS87yAl-IBMOp7Dzx4fLQClbQpjtQmvBvK7bQZY7YSiw3KViiQ"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 441122334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 400
    And response body should contain value of "65106" for key "errors[0].code"
    And response body should contain value of "Customer onboarding state is incompatible" for key "errors[0].description"


  @createCustomerProductOnboardingStatus204
  Scenario: Create Customer Product Onboarding - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhZDEzMzEzMC02NzBhLTQ5ZjctYmI1Ny0zMDM2YWIyZGRiNjYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI1NjBiNDZjMC03ZmUyLTQ1ZDktOTVhOC01YTI0ZDc3NzRjNWQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAzMzEzOTA2LCJleHAiOjE2MDM5MTg3MDZ9.sUp-m90htIWEyGLbHjyY2hdt90zg5IxbTPaO_pxc_WpDB0kTk-FB40Vj6YMZhr2J3g9CcdOfgdmmQTgy5W5CnA"
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
      "status": "ACTIVE",
      "town": "string"
    }
  ],
  "phone": 449903334448,
  "profile": {
    "dateOfBirth": "1987-07-07",
    "givenNames": "Nesrin",
    "preferredName": "Nesrin",
    "surname": "Yilmaz"
  }
}
"""
    When I PUT request to "/v1/customers/details"
    Then response status code should be 204

