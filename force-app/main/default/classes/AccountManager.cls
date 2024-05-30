@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    global class AccountWithContacts {
        public Account account { get; set; }
        public List<Contact> contacts { get; set; }
    }

    @HttpGet
    global static AccountWithContacts getAccount() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substringBetween('/Accounts/', '/contacts');

        AccountWithContacts result = new AccountWithContacts();
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Id = :accountId 
            LIMIT 1
        ];
        if (!accounts.isEmpty()) {
            result.account = accounts[0];
        }

        result.contacts = [
            SELECT Id, LastName 
            FROM Contact 
            WHERE AccountId = :accountId
        ];

        return result;
    }
}
