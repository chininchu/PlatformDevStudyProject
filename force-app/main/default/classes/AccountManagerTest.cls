@isTest
private class AccountManagerTest {
    @isTest
    static void testGetAccount() {
        Id recordId = createTestRecord();
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Set up a test response
        RestResponse response = new RestResponse();
        RestContext.response = response;
        
        // Call the method to test
        AccountManager.AccountWithContacts result = AccountManager.getAccount();
        
        // Verify results
        System.assert(result != null, 'Result should not be null');
        System.assert(result.account != null, 'Account should not be null');
        System.assertEquals('Test record', result.account.Name, 'Account name should be "Test record"');
        System.assert(result.contacts != null, 'Contacts should not be null');
        System.assertEquals(1, result.contacts.size(), 'There should be one contact');
        System.assertEquals('Test', result.contacts[0].LastName, 'Contact last name should be "Test"');
    }

    // Helper method
    static Id createTestRecord() {
        // Create test account
        Account testAcc = new Account(
            Name = 'Test record'
        );
        insert testAcc;
        
        // Create test contact linked to the test account
        Contact testCon = new Contact(
            LastName = 'Test',
            AccountId = testAcc.Id
        );
        insert testCon;
        
        return testAcc.Id;
    }
}
