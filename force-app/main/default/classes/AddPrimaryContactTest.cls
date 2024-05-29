@isTest
private class AddPrimaryContactTest {
    @isTest static void testInsertContacts() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            testAccounts.add(new Account(Name='Test NY ' + i, BillingState='NY'));
            testAccounts.add(new Account(Name='Test CA ' + i, BillingState='CA'));
        }
        insert testAccounts;

        Contact primaryContact = new Contact(LastName='Test', Email='test@example.com'); // Base contact

        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(primaryContact, 'CA'); 
        System.enqueueJob(job); 
        Test.stopTest(); 

        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE BillingState = 'CA')];

        System.assert(insertedContacts.size() == 50, '50 contacts should have been inserted');
    }
}