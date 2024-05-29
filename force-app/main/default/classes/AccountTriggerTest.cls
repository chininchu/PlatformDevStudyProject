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
private class AccountTriggerTest {

    @isTest static void verifyShippingState() {


        List<Account> testAccounts = new List<Account>();

             // Create 200 test records with BillingState = 'CA'
             for (Integer i = 0; i < 200; i++) {
                Account acc = new Account(Name = 'Test Account ' + i, BillingState = 'CA');
                testAccounts.add(acc);
            }

                    // Insert the records (this fires the trigger)

        Test.startTest();         
        insert testAccounts; 
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, ShippingState FROM Account WHERE Id IN :testAccounts];


        for(Account acc : updatedAccounts){


            System.assertEquals('CA', acc.ShippingState, 'ShippingState should be updated to "CA');







        
        }
    
    }
}