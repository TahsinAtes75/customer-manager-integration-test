package com.hymnai.backend.steps;

import com.hymnai.backend.exception.BackendTestException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;
import org.hamcrest.Matchers;
import org.junit.Assert;
import mailslurpmodels.Email;
import mailslurpmodels.Inbox;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hamcrest.Matchers;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.Matchers.*;

public class stepDefinitions extends Base{

    private String variable = null;

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
}


