Feature: Generate Onfido Token

  Background:
    Given I set REST API url as "https://customer-manager.test.heymanai.com"
    And I set request header content type as JSON

  @getOnfidotokenStatus200
  Scenario:Generate Onfido Token - Get onfido token happy path
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkMWJlZDc1OS0wZWQ1LTQ2YzgtODRhYS0zZmI5MDFkNmQ0OWYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MzA5MDcwLCJleHAiOjE1OTQ5MTM4NzB9.h0fFB8ETvsH6qQbROUnAwUJ79dmVfpyApJ1jQ0R4Ts92vbqoiky0cOasBt3-OO56w2GizQTtYLDXjr6AYNwUnQ"
    And I set request body with information given in the following json
   """
 {
  "aplicationId": "12345678"
 }
   """
    When I POST request to "/v1/kyc/onfido/token"
    Then response status code should be 200

  @getOnfidotokenStatus401
  Scenario Outline:Generate Onfido Token - Token validation with veriyf token and invalid token
    And I set header "authorization" parameter with value "<tokenValue>"
    And I set request body with information given in the following json
 """
  {
  "aplicationId": "12345678"
  }
   """
    When I POST request to "/v1/kyc/onfido/token"
    Then response status code should be 401
    And response body should contain value of "67005" for key "errors[0].code"
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

  @getOnfidotokenStatus403
  Scenario:Generate Onfido Token - Token validation with agent token
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1ODU0MTRjYy03OWQzLTQyMjktYWEyZC01N2RmMzQ1YzhiYTUiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJkZW1vMiIsInNjb3BlIjoiQUdFTlQiLCJpYXQiOjE1OTQzNzk2MTMsImV4cCI6MTU5NDk4NDQxM30.xESjHkHVMBv_yrx6NdT9rsyv1fg-uSVnqNd1XOyqKBcEr9rJWlGgqPMEjAsBQkTnid2WzyQTS3D4ycy_ts0vuQ"
    And I set request body with information given in the following json
 """
  {
  "aplicationId": "12345678"
  }
   """
    When I POST request to "/v1/kyc/onfido/token"
    Then response status code should be 403
    And response body should contain value of "65013" for key "errors[0].code"
    And response body should contain value of "Access denied" for key "errors[0].description"

  @getOnfidotokenStatus400
  Scenario:Generate Onfido Token - Invalid Aplication ID
    And I set header "authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkMWJlZDc1OS0wZWQ1LTQ2YzgtODRhYS0zZmI5MDFkNmQ0OWYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiJmYmY3MGZkNi03NDNkLTQ4ZTEtOGU3ZC1iY2U2Mzk0ODlmYzgiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNTk0MzA5MDcwLCJleHAiOjE1OTQ5MTM4NzB9.h0fFB8ETvsH6qQbROUnAwUJ79dmVfpyApJ1jQ0R4Ts92vbqoiky0cOasBt3-OO56w2GizQTtYLDXjr6AYNwUnQ"
    And I set request body with information given in the following json
  """
  {
  "aplicationId": ""
  }
   """
    When I POST request to "/v1/kyc/onfido/token"
    Then response status code should be 400
    And response body should contain value of "65201" for key "errors[0].code"
    And response body should contain value of "Could not create applicant. Reason : There was a validation error on this request (status code 422) | Field errors: {application_id=[Please specify a valid application_id]}" for key "errors[0].description"

