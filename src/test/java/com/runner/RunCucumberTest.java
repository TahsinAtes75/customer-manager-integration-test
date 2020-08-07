package com.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)

@CucumberOptions(

        plugin = {
                "pretty",
                "json:target/cucumber.json",
                "html:target/default-cucumber-reports"
        },

        tags = {},

        features = {"src/test/resources/features/CM_Refactor_Resend_Email_Verification_Link_for_Agent.feature"
        },

        glue = {"com/hymnai/backend/steps"},

        dryRun = false

)



public class RunCucumberTest {

}
