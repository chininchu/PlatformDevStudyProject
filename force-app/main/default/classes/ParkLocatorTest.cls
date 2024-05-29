@IsTest
public class ParkLocatorTest {
    @IsTest
    static void testCountryMethod() {
        // Set the mock callout
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        // Call the method to test
        List<String> parks = ParkLocator.country('United States');

        // Verify the results
        System.assertNotEquals(0, parks.size(), 'Parks should be returned');
        System.assertEquals(2, parks.size(), 'There should be 2 parks returned');
        System.assertEquals('Central Park', parks[0], 'First park should be Central Park');
        System.assertEquals('Golden Gate Park', parks[1], 'Second park should be Golden Gate Park');
    }
}