public class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Lead> leadsToUpdate = [
      SELECT Id
      FROM Lead
      WHERE LeadSource = NULL
      LIMIT 200
    ];

    for (Lead leadToUpdate : leadsToUpdate) {
      leadToUpdate.LeadSource = 'Dreamforce';
    }

    update leadsToUpdate;
  }
}
