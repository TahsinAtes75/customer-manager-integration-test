package com.hymnai.backend.steps;

import com.mailslurp.api.api.InboxControllerApi;
import com.mailslurp.api.api.WaitForControllerApi;
import com.mailslurp.client.ApiClient;
import com.mailslurp.client.ApiException;
import com.mailslurp.models.Email;
import com.mailslurp.models.Inbox;
import java.util.UUID;

public class EmailProvider {

  private static ApiClient mailslurpClient;

  public EmailProvider() {
    MailSlurpConfiguration configuration = new MailSlurpConfiguration();
    mailslurpClient = com.mailslurp.client.Configuration.getDefaultApiClient();
    mailslurpClient.setApiKey(configuration.API_KEY_STRING);
    mailslurpClient.setConnectTimeout(configuration.TIME_OUT);
  }

  public Inbox createInbox() throws Exception {
    // create a real, randomized email address with MailSlurp to represent a user
    InboxControllerApi inboxControllerApi = new InboxControllerApi(mailslurpClient);
    return inboxControllerApi.createInbox(null, null, null, null, null, null);
  }

  public Email getLatestEmail(UUID inboxId) throws Exception {
    // create an email address
    WaitForControllerApi apiInstance = new WaitForControllerApi(mailslurpClient);
    Email email = null;
    try {
      email = apiInstance.waitForLatestEmail(inboxId, 3000L, false);
    } catch (ApiException e) {
      System.err.println("Exception when calling WaitForControllerApi#waitForLatestEmail");
      System.err.println("Status code: " + e.getCode());
      System.err.println("Reason: " + e.getResponseBody());
      System.err.println("Response headers: " + e.getResponseHeaders());
      e.printStackTrace();
    }
    return email;
  }
}
