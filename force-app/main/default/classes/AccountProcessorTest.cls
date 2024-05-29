@isTest
private class AccountProcessorTest {
    @isTest
    private static void testCountContacts() {
        // Create Test Accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        // Create Test Contacts 
        List<Contact> testContacts = new List<Contact>();
        testContacts.add(new Contact(LastName='Smith', AccountId=testAccounts[0].Id)); 
        testContacts.add(new Contact(LastName='Jones', AccountId=testAccounts[0].Id)); 
        testContacts.add(new Contact(LastName='Lee', AccountId=testAccounts[1].Id)); 
        insert testContacts;

        // Call the future method
        Test.startTest(); 
        AccountProcessor.countContacts(new List<Id>{testAccounts[0].Id, testAccounts[1].Id});
        Test.stopTest(); // Ensures asynchronous code executes

        // Verify Results
        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :testAccounts];
        System.assertEquals(2, updatedAccounts[0].Number_Of_Contacts__c);
        System.assertEquals(1, updatedAccounts[1].Number_Of_Contacts__c);
    }
}