package com.hymnai.backend.steps;

import com.hymnai.backend.exception.BackendTestException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import mailslurpmodels.Email;
import mailslurpmodels.Inbox;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.Matchers.*;

public class stepDefinitions extends Base{

    private static final String AUTHORIZATION = "authorization";
    private final Logger LOGGER = LoggerFactory.getLogger(AssertionSteps.class);
    static Map<Integer, Integer> globalValues = new HashMap();
    static final String BASE_URL = "https://banking-web.dev.heymanai.com/email-verification/";

    private int getGlobalValue(int key) {
        return globalValues.containsKey(key) ? globalValues.get(key) : key;
    }

    @And("^response body should contain value of (\\d+) for key \"(.*?)\"$")
    public void responseBodyShouldContainValueOfForKey(int value, String path) throws BackendTestException {
        try {
            ((ValidatableResponse)((ValidatableResponse)response.then()).assertThat()).body(getGlobalValue(path), equalTo(getGlobalValue(value)), new Object[0]);
        } catch (Exception var4) {
            throw new BackendTestException(var4, this.LOGGER);
        }
    }

    @And("response body should contain value not equal to {int} for key {string}")
    public void responseBodyShouldContainValueNotEqualToForKey(int value, String path) throws BackendTestException {
        try {
            ((ValidatableResponse)((ValidatableResponse)response.then()).assertThat()).body(getGlobalValue(path), is(not(equalTo(getGlobalValue(value)))), new Object[0]);
        } catch (Exception var4) {
            throw new BackendTestException(var4, this.LOGGER);
        }
    }

    @And("response body should contain the key {string} with a not-null value")
    public void responseBodyShouldContainTheKeyWithANotNullValue(String path) throws BackendTestException {
        try {
            ((ValidatableResponse)((ValidatableResponse)response.then()).assertThat()).body(getGlobalValue(path), notNullValue(), new Object[0]);
        } catch (Exception var4) {
            throw new BackendTestException(var4, this.LOGGER);
        }
    }

    @When("I POST request to {string} with random email")
    public void generateAndCaptureEmailAndAddJwtToHeader(String url) throws BackendTestException {
        try {
            EmailProvider emailProvider = new EmailProvider();
            Inbox inbox = emailProvider.createInbox();
            String request = createRequestAsJson(inbox.getEmailAddress());
            reqSpec.given().body(request);
            response = (Response)reqSpec.when().post(url, new Object[0]);
            Email email = emailProvider.getLatestEmail(inbox.getEmailAddress());
            String jwt = parseJWT(email.getBody());
            addHeaderParameter(AUTHORIZATION, jwt);
        } catch (Exception e) {
            throw new BackendTestException(e, this.LOGGER);
        }
    }

    @When("I POST request with email {string} to {string}")
    public void captureEmailAndAddJwtToHeader(String emailAddress, String url) throws BackendTestException {
        try {
            EmailProvider emailProvider = new EmailProvider();
            String request = createRequestAsJson(emailAddress);
            reqSpec.given().body(request);
            response = (Response) reqSpec.when().post(url, new Object[0]);
            Email email = emailProvider.getLatestEmail(emailAddress);
            String jwt = parseJWT(email.getBody());
            addHeaderParameter(AUTHORIZATION, jwt);
            Base.globalValues.put(AUTHORIZATION, jwt);
        } catch (Exception e) {
            throw new BackendTestException(e, this.LOGGER);
        }
    }

    private String parseJWT(String message) {
        int startIndex = message.indexOf(BASE_URL) + BASE_URL.length();
        int endIndex = message.indexOf(" ", startIndex) -1;
        if (endIndex == -1) {
            endIndex = message.length();
        }
        String jwt = message.substring(startIndex, endIndex);
        return jwt;
    }
    private String createRequestAsJson(String emailAddress) {
        String json =
        "{\n"
            + "  \"email\": \"" + emailAddress +"\",\n"
            + "  \"make\": \"string\",\n"
            + "  \"model\": \"string\",\n"
            + "  \"serialNo\": \"string\"\n"
            + "}";
        return json;
    }

}


