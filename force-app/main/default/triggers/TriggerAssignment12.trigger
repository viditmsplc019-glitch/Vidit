trigger TriggerAssignment12 on Opportunity (after insert) {
    Set<Id> accIds = new Set<Id>();
    for (Opportunity opp : Trigger.new) {
        if (opp.AccountId != null) {
            accIds.add(opp.AccountId);
        }
    }
    
    List<Opportunity> allOpps = [SELECT Id, Amount, CreatedDate, AccountId FROM Opportunity WHERE AccountId IN :accIds ORDER BY CreatedDate DESC];
    
    List<Account> accLstUpdate = new List<Account>();
    Set<Id> updatAcc = new Set<Id>();
    
    for (Opportunity opp : allOpps) {					
        if (!updatAcc.contains(opp.AccountId)) {
            Account acc = new Account(Id = opp.AccountId, Recent_Opportunity_Amount__c = opp.Amount);
            accLstUpdate.add(acc);
            updatAcc.add(opp.AccountId); 
        }
    }
    
    if (!accLstUpdate.isEmpty()) {
        //update accLstUpdate;
    }
}