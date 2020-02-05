Feature: Customer Onboarding - Happy Path Whole Process

  Background:
    Given I set REST API url as "https://customer-manager.lab.heymanai.com"


  @captureEmailHappyPath
  Scenario: Capture Email - Happy Path
    And I set request header content type as JSON
    And I set request body with information given in the following table
      | email    | onb_happy_path_1@hymnai.com |
      | make     | Apple                       |
      | model    | iphone7                     |
      | serialNo | 12345                       |
    When I POST request to "/v1/customers/onboarding"
    Then response status code should be 200
    And response body should contain value of "onb_happy_path_1@hymnai.com" for key "email"
    And response body should contain value of "EMAIL_CAPTURED" for key "status"
    And response body should contain the key "key" with a not-null value


  ###
  # Manually get the verification token value from DB for the given email
  ###
  @verifyEmailHappyPath
  Scenario: Verify Email - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDkxNjA0NCwiZXhwIjoxNTgxMDAyNDQ0fQ.71k4fvcdNZboCZorST654twC42Oc7aJ0YExcDeMfEsqLxgTaJ1IKuz-De-tL0D2vtYZjYr_ZMFP5lpKpUeUU3w"
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
    And response body should be following json
    """
    {
      "email": "onb_happy_path_1@hymnai.com",
      "status": "EMAIL_VERIFIED"
}
    """

    ###
    # Manually get the onboarding token from API with the verification token above
    ###
  @putNameAndDoBHappyPath
  Scenario: Put Name and DoB - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTYxMTcsImV4cCI6MTU4ODY5MjExN30.2F07BGlNa6Xb3noHoDRYHQBO07Uq1_iNjG2RPkdFGXgWUnf3pH5CuAtcvDFb5CIcOfeJMvYWEtyGy5QQ-UXy7A"
    And I set request body with information given in the following table
      | givenNames  | Ebru       |
      | surname     | Soysal     |
      | dateOfBirth | 1982-01-01 |
    When I PUT request to "/v1/customers/profile"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_1@hymnai.com",
    "givenNames": "Ebru",
    "surname": "Soysal",
    "dateOfBirth": "1982-01-01",
    "status": "NAME_DOB_CAPTURED"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @putPhoneNumberHappyPath
  Scenario: Put Phone Number - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTYxMTcsImV4cCI6MTU4ODY5MjExN30.2F07BGlNa6Xb3noHoDRYHQBO07Uq1_iNjG2RPkdFGXgWUnf3pH5CuAtcvDFb5CIcOfeJMvYWEtyGy5QQ-UXy7A"
    And I set request body with information given in the following table
      | phone | 449999999999 |
    When I PUT request to "/v1/customers/phone"
    Then response status code should be 200
    And response body should be following json
  """
  {
    "email": "onb_happy_path_1@hymnai.com",
    "phone": "449999999999",
    "status": "TELEPHONE_CAPTURED"
   }
  """

  ###
  # Manually get the onboarding token from API with the verification token above
  # Manually get the sms code from DB
  ###
  @verifyPhoneNumberHappyPath
  Scenario: Verify Phone Number - Happy Path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTYxMTcsImV4cCI6MTU4ODY5MjExN30.2F07BGlNa6Xb3noHoDRYHQBO07Uq1_iNjG2RPkdFGXgWUnf3pH5CuAtcvDFb5CIcOfeJMvYWEtyGy5QQ-UXy7A"
    And I set query parameter "phone" with value "449999999999"
    And I set query parameter "code" with value "068898"
    When I POST request to "/v1/customers/phone/verify"
    Then response status code should be 200
    And response body should contain value of "TELEPHONE_VERIFIED" for key "status"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @captureAddressHappyPath
  Scenario: Capture Address - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTYxMTcsImV4cCI6MTU4ODY5MjExN30.2F07BGlNa6Xb3noHoDRYHQBO07Uq1_iNjG2RPkdFGXgWUnf3pH5CuAtcvDFb5CIcOfeJMvYWEtyGy5QQ-UXy7A"
    And I set request body with information given in the following table
      | country  | UK             |
      | line1    | 3 Queen's Road |
      | line2    |                |
      | postCode | RG1 4AP        |
      | town     | Reading        |
    When I POST request to "/v1/customers/addresses"
    Then response status code should be 200
    And response body should contain value of "ADDRESS_CAPTURED" for key "status"


  ###
  # Manually get the onboarding token from API with the verification token above
  ###
  @capturePasscodeHappyPath
  Scenario: Capture Passcode - Happy Path
    And I set request header content type as JSON
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4Nzg4OWZlOC1iMWQyLTQ2ODUtYWFhNi1kNjdmOWMzYTY2OTciLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODA5MTYxMTcsImV4cCI6MTU4ODY5MjExN30.2F07BGlNa6Xb3noHoDRYHQBO07Uq1_iNjG2RPkdFGXgWUnf3pH5CuAtcvDFb5CIcOfeJMvYWEtyGy5QQ-UXy7A"
    And I set request body with information given in the following table
      | passcode | 123456 |
    When I POST request to "/v1/customers/passcode"
    Then response status code should be 200
    And response body should contain value of "ACTIVE" for key "status"