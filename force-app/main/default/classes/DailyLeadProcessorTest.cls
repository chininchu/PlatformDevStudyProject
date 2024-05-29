@isTest

private class DailyLeadProcessorTest {
    
    
     @isTest static void testScheduledUpdate() {
        // 1. Data Setup
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(LastName = 'Test Lead ' + i, Company = 'Test Co.')); 
        }
        insert testLeads;

        // 2. Schedule the Job
        Test.startTest(); 
        String cronExp = '0 0 0 * * ?'; // Run immediately for testing 
        System.schedule('Test DailyLeadProcessor', cronExp, new DailyLeadProcessor());
        Test.stopTest(); 

        // 3. Verification
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testLeads];

        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated');
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}