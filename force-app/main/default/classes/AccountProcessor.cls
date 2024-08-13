public class AccountProcessor {
  public static List<Account> processAccounts(
    List<Account> accounts,
    System.AccessLevel accessLevel
  ) {
    // Strip inaccessible fields before processing
    SObjectAccessDecision decision = Security.stripInaccessible(
      AccessType.READABLE,
      accounts
    );

    List<Account> strippedAccounts = (List<Account>) decision.getRecords();

    for (Account acc : strippedAccounts) {
      if (accessLevel == System.AccessLevel.SYSTEM_MODE) {
        // In system mode, we can update all fields
        if (acc.AnnualRevenue > 1000000) {
          acc.Large_Account__c = true;
          acc.Description = 'Large Account processed in System Mode';
        } else {
          acc.Large_Account__c = false;
          acc.Description = 'Small Account processed in System Mode';
        }
      } else if (accessLevel == System.AccessLevel.USER_MODE) {
        // In user mode, we only update fields the user has access to
        if (acc.AnnualRevenue > 1000000) {
          acc.Large_Account__c = true;
        } else {
          acc.Large_Account__c = false;
        }
      }
    }

    return strippedAccounts;
  }
}
