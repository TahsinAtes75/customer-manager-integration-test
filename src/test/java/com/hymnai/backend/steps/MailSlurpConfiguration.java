package com.hymnai.backend.steps;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class MailSlurpConfiguration {

  public final int TIME_OUT;
  public final String AUTH_NAME;
  public final String API_KEY_STRING;

  MailSlurpConfiguration() {
    ClassLoader loader = Thread.currentThread().getContextClassLoader();
    Properties properties = new Properties();
    try (InputStream resourceStream = loader.getResourceAsStream(
        "application.properties")) {
      properties.load(resourceStream);
    } catch (IOException e) {
      e.printStackTrace();
    }
    TIME_OUT = Integer.valueOf(properties.getProperty("mailSlurp.timeOut"));
    AUTH_NAME = properties.getProperty("mailSlurp.authName");
    API_KEY_STRING = properties.getProperty("mailSlurp.apiKey");
  }
}
