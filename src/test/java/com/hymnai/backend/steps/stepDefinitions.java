package com.hymnai.backend.steps;

import com.hymnai.backend.exception.BackendTestException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.restassured.response.ValidatableResponse;
import org.hamcrest.Matchers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hamcrest.Matchers;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.Matchers.*;

public class stepDefinitions extends Base{

    private final Logger LOGGER = LoggerFactory.getLogger(AssertionSteps.class);
    static Map<Integer, Integer> globalValues = new HashMap();

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
}


