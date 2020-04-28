Feature: Send Email PDF - Backend

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"

  @sendCustomerStatementEmailStatus401
  Scenario Outline:Send Email PDF - Token validation with veriyf token and invalid token
    And I set header "authorization" parameter with value "<tokenValue>"
    When I POST request to "/v1/customers/statements"
    And I set request body with information given in the following json
   """
   {
  "accountNumber": "****1234",
  "accountType": "Current Account",
  "customerKey": "d40c45a2-0526-44df-9030-ead6eaf2aa6f",
  "date": "2020-04-30T00:00:00",
  "description": "Basic current account statement",
  "fileName": "47545ea8-7e80-33bb-9e6c-958fd5a080d2_30-04-2020.pdf"
   """
    Then response status code should be 401
    And response body should contain value of "67555" for key "errors[0].code"
    And response body should contain value of "Access token is invalid" for key "errors[0].description"
    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      |                                                                                                                                                                                                                                                                                    |
      | asd                                                                                                                                                                                                                                                                                |
      | ayJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJIeW1uYWkiLCJzdWIiOiIwYTgxMThmNS1jYjljLTQ0NzAtOWUwMC0zMjAyOTA5OGE4MWIiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4MDEzNDUxNywiZXhwIjoxNTgwMjIwOTE3fQ.azYVhfG_xvNlpwHoOqWJt_BKlhB4Euz0_s91SEqiB-kLiP1MyKUIMNn3KJR9zUJ_nZrs92Ot-MNBZpbNdMzj2A |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIzZTQ5ZDdhYS1jZjc3LTQ5OWUtODViOS04M2NiYTQxNWJhYjMiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6IkVNQUlMX1ZFUklGSUNBVElPTiIsImlhdCI6MTU4Njk2NzY4NywiZXhwIjoxOTAyNTAyMDkyfQ.fAyZfl_addQq2E0L5POJxUtuNNGMknWklp6J2vquqoJTuMOIxMWOe8lJNecP05imuAb6JwyG8XOn2wwFMo37CA |
  ###
  # Last validation for when we called the api with "verify token"
  ###

  @sendCustomerStatementEmailStatus403

  Scenario Outline:Send Email PDF - Token validation with customer token and Onboarding token
    And I set header "authorization" parameter with value "<tokenValue>"
    When I POST request to "/v1/customers/statements"
    And I set request body with information given in the following json
   """
   {
  "accountNumber": "****1234",
  "accountType": "Current Account",
  "customerKey": "d40c45a2-0526-44df-9030-ead6eaf2aa6f",
  "date": "2020-04-30T00:00:00",
  "description": "Basic current account statement",
  "fileName": "47545ea8-7e80-33bb-9e6c-958fd5a080d2_30-04-2020.pdf"
   """
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"
    Examples:
      | tokenValue                                                                                                                                                                                                                                                                         |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5NDIwYTIwOS1lODhkLTRiNjUtYTY0NC1kMWQzNjNjNzU5YTIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJjMTU3NjU5My1mYWEwLTRjNTgtYTI5NS0wZDFiMjY5MDYxMDQiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTg3MDM1NjQ1LCJleHAiOjE5MDI1Njg1MzF9.fjt_6OzKCVGz-IdRqlLezTI47zw1B-lXNSCtpkkkmVSdgRHbR3T1ReC0JZ3HcPGIOMH_CFpLixOGcFUkmSCjjg |
      | eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YWIzMDBiYS0yYWM0LTQ4NGItYTQzOS1lNTdjZTRjOWE1ZjAiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI5ZGE3NWQ2ZS0yZmFhLTQzNjYtOTRmYi0yYzczNGY0YjMxOTUiLCJzY29wZSI6Ik9OQk9BUkRJTkciLCJpYXQiOjE1ODY5NjgxMjUsImV4cCI6MTkwMjUwMzc4M30.WyPC_RySFaEcHvamDI59vy379WlHz94pHkk5KzzI6XWCiewBENUWnD5TNBZgU2kK_rpB4xjSe0ujy-whfuTb0g|


  @sendCustomerStatementEmailStatus400
  Scenario:Send Email PDF - Invalid file name
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4MGVhZjFiNy0xNGE5LTQ4MjYtODY1Mi02MGNjY2JkM2Q2NzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFJhYmlhIiwic2NvcGUiOiJBR0VOVCIsImlhdCI6MTU4Njk2MTQ0MCwiZXhwIjoxOTAyNDk0NDUxfQ.uDshnfLeKykyKy5RQG38VzfNQfRnzAGPgmq9uoUWsrIA2sPrhcAUEo93Xx142LyI8lO24ajkqsRIMUhROhbdKQ"
    When I POST request to "/v1/customers/statements"
    And I set request body with information given in the following json
   """
   {
  "accountNumber": "****1234",
  "accountType": "Current Account",
  "customerKey": "d40c45a2-0526-44df-9030-ead6eaf2aa6f",
  "date": "2020-04-30T00:00:00",
  "description": "Basic current account statement",
  "fileName": "47545ea8-7e80-33bb-9e6c-958fd5a080d2_30-04-2060.pdf"
   """
    Then response status code should be 400
    And response body should contain value of "65029" for key "errors[0].code"
    And response body should contain value of "Could not find statement file with given details at AWS S3 bucket" for key "errors[0].description"



  @sendCustomerStatementEmailStatus204
  Scenario:Send Email PDF happy path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4MGVhZjFiNy0xNGE5LTQ4MjYtODY1Mi02MGNjY2JkM2Q2NzkiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJBZ2VudFJhYmlhIiwic2NvcGUiOiJBR0VOVCIsImlhdCI6MTU4Njk2MTQ0MCwiZXhwIjoxOTAyNDk0NDUxfQ.uDshnfLeKykyKy5RQG38VzfNQfRnzAGPgmq9uoUWsrIA2sPrhcAUEo93Xx142LyI8lO24ajkqsRIMUhROhbdKQ"
    When I POST request to "/v1/customers/statements"
    And I set request body with information given in the following json
   """
   {
  "accountNumber": "****1234",
  "accountType": "Current Account",
  "customerKey": "d40c45a2-0526-44df-9030-ead6eaf2aa6f",
  "date": "2020-04-30T00:00:00",
  "description": "Basic current account statement",
  "fileName": "47545ea8-7e80-33bb-9e6c-958fd5a080d2_30-04-2020.pdf"
   """
    Then response status code should be 204


