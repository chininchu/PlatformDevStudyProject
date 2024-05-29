public class AddPrimaryContact implements Queueable {
    private Contact primaryContact;
    private String stateCode; 

    public AddPrimaryContact(Contact contactToClone, String billingState) {
        this.primaryContact = contactToClone.clone(false, false, false, false); 
        this.stateCode = billingState; 
    }

    public void execute(QueueableContext context) {
        List<Account> targetAccounts = [SELECT Id FROM Account WHERE BillingState = :stateCode LIMIT 200];
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : targetAccounts) {
            Contact newContact = primaryContact.clone(false, false, false, false);
            newContact.AccountId = acc.Id;
            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }
}