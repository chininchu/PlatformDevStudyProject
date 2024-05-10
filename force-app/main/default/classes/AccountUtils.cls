public with sharing class AccountUtils {


    public static List<Account>  accountsByState(String stateAbbr) {

  

         return [SELECT Id, Name FROM Account WHERE BillingState = :stateAbbr WITH SECURITY_ENFORCED];


        

    }
}