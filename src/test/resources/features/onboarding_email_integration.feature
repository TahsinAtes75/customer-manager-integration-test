Feature: Customer Onboarding - Capture Customer Email

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @captureAndVerifyRandomEmail
  Scenario: Capture Email - Email Validation With Random Email Addresses Test
    And I set request header content type as JSON
    When I POST request to "/v1/customers/onboarding" with random email
    Then response status code should be 200

    Given I set request header content type as JSON
    When I POST request to "/v1/customers/verify"
    Then response status code should be 200
