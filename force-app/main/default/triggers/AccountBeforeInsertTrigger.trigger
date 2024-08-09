trigger AccountBeforeInsertTrigger on Account (before insert) {
    for(Account acc : Trigger.new) {
        // 1. Set a default value if a field is blank
        if(String.isBlank(acc.Industry)) {
            acc.Industry = 'Other';
        }
        
        // 2. Enforce a business rule
        if(acc.AnnualRevenue != null && acc.AnnualRevenue > 1000000) {
            acc.Rating = 'Hot';
        }
        
        // 3. Modify the data before insert
        if(acc.Name != null) {
            acc.Name = acc.Name.trim();
        }
        
        // 4. Validate data
        if(acc.Phone != null && acc.Phone.length() < 10) {
            acc.Phone.addError('Phone number must be at least 10 digits long.');
        }
    }
}