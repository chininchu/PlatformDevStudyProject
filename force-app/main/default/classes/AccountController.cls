public with sharing class AccountController {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    AccessLevel userMode = AccessLevel.USER_MODE;

    return [
      SELECT Id, Name, Industry, AnnualRevenue
      FROM Account
      WITH USER_MODE
      LIMIT 100
    ];
  }

  @AuraEnabled
  public static List<Account> updateRecords(List<Account> accountsToUpdate) {
    try {
      // Create a set of Account Ids to query
      Set<Id> accountIds = new Set<Id>();
      for (Account acc : accountsToUpdate) {
        accountIds.add(acc.Id);
      }

      // Query for full account records
      Map<Id, Account> existingAccounts = new Map<Id, Account>(
        [
          SELECT Id, Name, Industry, AnnualRevenue
          FROM Account
          WHERE Id IN :accountIds
        ]
      );

      // Update only the fields that were changed
      for (Account updatedAccount : accountsToUpdate) {
        Account existingAccount = existingAccounts.get(updatedAccount.Id);
        if (existingAccount != null) {
          existingAccount.Name = updatedAccount.Name != null
            ? updatedAccount.Name
            : existingAccount.Name;
          existingAccount.Industry = updatedAccount.Industry != null
            ? updatedAccount.Industry
            : existingAccount.Industry;
          existingAccount.AnnualRevenue = updatedAccount.AnnualRevenue != null
            ? updatedAccount.AnnualRevenue
            : existingAccount.AnnualRevenue;
        }
      }

      update existingAccounts.values();
      return existingAccounts.values();
    } catch (Exception e) {
      throw new AuraHandledException(
        'Error updating accounts: ' + e.getMessage()
      );
    }
  }
}
