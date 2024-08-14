/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AnimalsCalloutsTest {
  @isTest
  static void testGetCallout() {
    // Create the mock response based on a static resource
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('GetAnimalResource');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    // Call method to test
    HttpResponse result = AnimalsCallouts.makeGetCallout();
    // Verify mock response is not null
    Assert.areNotEqual(null, result, 'The callout returned a null response.');
    // Verify status code
    Assert.areEqual(200, result.getStatusCode(), 'The status code is not 200.');
    // Verify content type
    Assert.areEqual(
      'application/json;charset=UTF-8',
      result.getHeader('Content-Type'),
      'The content type value is not expected.'
    );
    // Verify the array contains 3 items
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      result.getBody()
    );
    List<Object> animals = (List<Object>) results.get('animals');
    Assert.areEqual(
      3,
      animals.size(),
      'The array should only contain 3 items.'
    );
  }

  @isTest
  static void testPostCallout() {
    // Set mock callout class
    Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock.
    HttpResponse response = AnimalsCallouts.makePostCallout();
    // Verify that the response received contains fake values
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json');
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }
}
