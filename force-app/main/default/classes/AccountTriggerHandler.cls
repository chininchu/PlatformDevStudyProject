public with sharing class AccountTriggerHandler {
  public static void createAccounts(List<Account> newAccounts) {
    for (Account acc : newAccounts) {
      acc.ShippingState = acc.BillingState;
    }
  }
}
