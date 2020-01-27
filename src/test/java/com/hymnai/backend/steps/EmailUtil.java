package com.hymnai.backend.steps;


import mailslurp.ApiClient;
import mailslurp.Configuration;
import mailslurp.auth.ApiKeyAuth;
import mailslurpapi.CommonOperationsApi;
import mailslurpmodels.Email;
import mailslurpmodels.Inbox;

public class EmailUtil {

 static {
   ApiClient defaultClient = Configuration.getDefaultApiClient();
   defaultClient.setConnectTimeout(60000);
   ApiKeyAuth API_KEY = (ApiKeyAuth) defaultClient.getAuthentication("API_KEY");
   API_KEY.setApiKey("a735d0252c8f419597e11874bbdede7ce50d66b8e1a4b7f7b221268f0f1ee996");
 }

  private EmailUtil() { }

  public static Inbox createInbox() throws Exception{
    // create an email address
    CommonOperationsApi apiInstance = new CommonOperationsApi();
    return apiInstance.createNewEmailAddressUsingPOST();
  }

  public static Email getLatestEmail(String inboxEmailAddress) throws Exception{
    // create an email address
    CommonOperationsApi apiInstance = new CommonOperationsApi();
    return apiInstance.fetchLatestEmailUsingGET(inboxEmailAddress, null);
  }
}
