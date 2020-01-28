package com.hymnai.backend.steps;


import mailslurp.ApiClient;
import mailslurp.Configuration;
import mailslurp.auth.ApiKeyAuth;
import mailslurpapi.CommonOperationsApi;
import mailslurpmodels.Email;
import mailslurpmodels.Inbox;

public class EmailProvider {

  public EmailProvider() {
    MailSlurpConfiguration configuration = new MailSlurpConfiguration();
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setConnectTimeout(configuration.TIME_OUT);
    ApiKeyAuth API_KEY = (ApiKeyAuth) defaultClient.getAuthentication(configuration.AUTH_NAME);
    API_KEY.setApiKey(configuration.API_KEY_STRING);
  }

  public Inbox createInbox() throws Exception {
    // create an email address
    CommonOperationsApi apiInstance = new CommonOperationsApi();
    return apiInstance.createNewEmailAddressUsingPOST();
  }

  public Email getLatestEmail(String inboxEmailAddress) throws Exception {
    // create an email address
    CommonOperationsApi apiInstance = new CommonOperationsApi();
    return apiInstance.fetchLatestEmailUsingGET(inboxEmailAddress, null);
  }
}
