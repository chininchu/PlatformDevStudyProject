@IsTest
public class AccountProcessorTest {
  @TestSetup
  static void setupTestData() {
    // Create test accounts
    List<Account> testAccounts = new List<Account>();
    for (Integer i = 0; i < 5; i++) {
      testAccounts.add(
        new Account(
          Name = 'Test Account ' + i,
          AnnualRevenue = (i + 1) * 500000 // Revenue from 500k to 2.5M
        )
      );
    }
    insert testAccounts;
  }

  @IsTest
  static void testProcessAccountsSystemMode() {
    // Retrieve test accounts
    List<Account> accounts = [
      SELECT Id, Name, AnnualRevenue, Large_Account__c, Description
      FROM Account
    ];

    Test.startTest();
    List<Account> processedAccounts = AccountProcessor.processAccounts(
      accounts,
      System.AccessLevel.SYSTEM_MODE
    );
    Test.stopTest();

    // Verify results
    System.assertEquals(
      5,
      processedAccounts.size(),
      'Should process 5 accounts'
    );

    for (Account acc : processedAccounts) {
      if (acc.AnnualRevenue > 1000000) {
        System.assert(
          acc.Large_Account__c,
          'Account with revenue > 1M should be marked as large'
        );
        System.assertEquals(
          'Large Account processed in System Mode',
          acc.Description,
          'Description should be updated for large account in System Mode'
        );
      } else {
        System.assert(
          !acc.Large_Account__c,
          'Account with revenue <= 1M should not be marked as large'
        );
        System.assertEquals(
          'Small Account processed in System Mode',
          acc.Description,
          'Description should be updated for small account in System Mode'
        );
      }
    }
  }

  @IsTest
  static void testProcessAccountsUserMode() {
    // Retrieve test accounts
    List<Account> accounts = [
      SELECT Id, Name, AnnualRevenue, Large_Account__c, Description
      FROM Account
    ];

    System.debug('Number of test accounts: ' + accounts.size());
    for (Account acc : accounts) {
      System.debug(
        'Test Account: Name=' +
          acc.Name +
          ', AnnualRevenue=' +
          acc.AnnualRevenue
      );
    }

    Test.startTest();
    List<Account> processedAccounts = AccountProcessor.processAccounts(
      accounts,
      System.AccessLevel.USER_MODE
    );
    Test.stopTest();

    // Verify results
    System.assertEquals(
      5,
      processedAccounts.size(),
      'Should process 5 accounts'
    );

    for (Account acc : processedAccounts) {
      if (acc.AnnualRevenue > 1000000) {
        System.assert(
          acc.Large_Account__c,
          'Account with revenue > 1M should be marked as large'
        );
      } else {
        System.assert(
          !acc.Large_Account__c,
          'Account with revenue <= 1M should not be marked as large'
        );
      }
      // In USER_MODE, Description should not be updated
      System.assertEquals(
        null,
        acc.Description,
        'Description should not be updated in User Mode'
      );
    }
  }
}
