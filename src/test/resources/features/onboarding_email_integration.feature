Feature: Customer Onboarding - Capture Customer Email

  Background:
    Given I set REST API url as "https://customer-manager.dev.heymanai.com"

  @captureAndVerifyRandomEmail
  Scenario: Capture Email - Email Validation With Random Email Addresses Test
    And I set request header content type as JSON
    When I POST request to "/v1/customers/onboarding" with random email
    Then response status code should be 200

    Given I set request header content type as JSON
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200

  @captureAndVerifyGivenEmail
  Scenario: Capture Email - Email Validation With Random Email Addresses Test4
    And I set request header content type as JSON
    When I POST request with email "a6a93ff3-2a57-45dc-81c3-62d23e3bd10b@mailslurp.com" to "/v1/customers/onboarding"
    Then response status code should be 200

    Given I set request header content type as JSON
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
