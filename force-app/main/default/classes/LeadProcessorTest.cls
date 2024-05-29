@isTest
private class LeadProcessorTest {
    @isTest 
    
    static void testBatchUpdate() {
        // Data Setup
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(LastName = 'Test Lead ' + i, Company = 'Test Co.')); 
        }
        insert testLeads;

        // Execute Batch
        Test.startTest(); 
        System.debug('Starting batch execution...');
        LeadProcessor myBatch = new LeadProcessor();
        Database.executeBatch(myBatch);
        Test.stopTest(); 
        System.debug('Batch execution finished.');

        // Verification
        // ... (rest of the test code) ...
    }
}