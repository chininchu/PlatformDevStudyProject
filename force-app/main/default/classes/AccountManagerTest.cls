@IsTest

private class AccountManagerTest {

    @isTest static void testGetAccount() {

        Account a = new Account(Name='Test Account');

        Insert a;

        Contact c = new Contact(AccountId=a.Id, FirstName='Test', LastName='Test');

        insert c;

        RestRequest request = new RestRequest();

        request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' + a.Id + '/contacts';

        

        request.httpMethod = 'GET';

        RestContext.request = request;

        Account myAcct = AccountManager.getAccount();

        System.assert(myAcct != null, 'message');

        System.assertEquals('TestAccount', myAcct.Name, 'messag1');
    
    }


}



