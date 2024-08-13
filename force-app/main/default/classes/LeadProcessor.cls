public class LeadProcessor implements Database.Batchable<sObject> {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('SELECT Id FROM Lead'); // Get all Leads
  }

  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    for (Lead lead : scope) {
      lead.LeadSource = 'Dreamforce';
    }
    update scope;
  }

  public void finish(Database.BatchableContext bc) {
    // Optional, you could send a summary email here
  }
}
