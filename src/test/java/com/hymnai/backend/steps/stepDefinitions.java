package com.hymnai.backend.steps;

import com.hymnai.backend.exception.BackendTestException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.restassured.response.ValidatableResponse;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hamcrest.Matchers;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.Matchers.*;

public class stepDefinitions extends Base{

    private String variable = null;

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

    @And("response body should contain the key {string} with a not-null value")
    public void responseBodyShouldContainTheKeyWithANotNullValue(String path) throws BackendTestException {
        try {
            ((ValidatableResponse)((ValidatableResponse)response.then()).assertThat()).body(getGlobalValue(path), notNullValue(), new Object[0]);
        } catch (Exception var4) {
            throw new BackendTestException(var4, this.LOGGER);
        }
    }

    @And("assign response value of {string} field to a variable")
    public void assignResponseValueOfFieldToAVariable(String key) throws BackendTestException, ParseException {
        Object x;
        reqSpec.given().queryParam(getGlobalValue("email"));
        response = reqSpec.when().post("https://customer-manager.test.heymanai.com/v1/customers", new Object[0]);
        x = response.print();
        JSONParser parser = new JSONParser();
        var json = (JSONObject)parser.parse(x.toString());
        this.variable = json.getAsString(key);
        System.out.println(this.variable);



    }

    @And("Assert that the variable equals to {string}")
    public void assertThatTheVariableEqualsTo(String expected) {
        Assert.assertEquals(this.variable,expected);
        System.out.println(this.variable);

    }
}


