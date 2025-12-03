public class TriggerAssignmentC {
    public static void trigassne(list<Contact> ccd){
        Set<Id> accid = new Set<Id>();
        
        for (Contact con : ccd) {
            if (con.Primary_Contact__c ){ 
                if(con.AccountId != null) {
                    accid.add(con.AccountId);
                }
            }
        }
        
        
        
        List<Contact> oldprimarycon = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accId AND Primary_Contact__c = true];
        
        for (Contact newcon : ccd) {
            if (newCon.Primary_Contact__c ){ 
                if(newCon.AccountId != null) {
                    for (Contact oldcon : oldprimarycon) {
                        
                        if (oldcon.AccountId == newCon.AccountId){ 
                            if(oldcon.Id != newCon.Id) {
                                newCon.addError('Not allowed More than one primaryContact');
                                break; 
                            }
                        }
                    }
                }
            }
        }
        
        
    }
}