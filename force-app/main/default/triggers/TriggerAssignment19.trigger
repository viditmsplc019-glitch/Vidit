trigger TriggerAssignment19 on Contact (after insert) {
    
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : Trigger.new) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }
    
    if (accountIds.isEmpty()) return;
    
    list<Opportunity>opplstAcc = [SELECT Id, Amount, AccountId  FROM Opportunity  WHERE AccountId IN :accountIds];
    Map<Id, List<Opportunity>> accountOppsMap = new Map<Id, List<Opportunity>>();
    for(Opportunity opp : opplstAcc) {
        if (!accountOppsMap.containsKey(opp.AccountId)) {
            accountOppsMap.put(opp.AccountId, new List<Opportunity>());
        }
        accountOppsMap.get(opp.AccountId).add(opp);
    }
    
    
    List<Account> accountsToUpdate = new List<Account>();
    List<Opportunity> newOpportunities = new List<Opportunity>();
    
    for (Id accId : accountIds) {
        if (accountOppsMap.containsKey(accId)   ) {
            
            Decimal totalAmount = 0;
            for (Opportunity opp : accountOppsMap.get(accId)) {
                if (opp.Amount != null) {
                    totalAmount = totalAmount + opp.Amount;
                }
            }
            accountsToUpdate.add(new Account(
                Id = accId,
                Description = 'Total Opportunity Amount: ' + String.valueOf(totalAmount)
            ));
        } else {
            
            newOpportunities.add(new Opportunity( Name = 'New Opportunity from Contact', StageName = 'Prospecting', CloseDate = System.today().addDays(30), Amount = 1000,  AccountId = accId  ));
        }
    }
    
    
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
    
    if (!newOpportunities.isEmpty()) {
        insert newOpportunities;
    }
}