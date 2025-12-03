trigger TriggerAssignment13 on Opportunity (before delete) {
    Set<Id> delOppId = new Set<Id>();
    Map<Id, Id> oppToAcc = new Map<Id, Id>();
    
    for (Opportunity opp : Trigger.old) {
        if (opp.AccountId != null) {
            delOppId.add(opp.Id);
            oppToAcc.put(opp.Id, opp.AccountId);
        }
    }
    
    if (delOppId.isEmpty()) return;
    
    List<Task> reltTsk = [ SELECT Id, WhatId,Subject FROM Task WHERE WhatId IN :delOppId];
    
    Set<Id> relaAccId = new Set<Id>(oppToAcc.values());
    
    List<Opportunity> othroppr = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :relaAccId AND Id NOT IN :delOppId ORDER BY CreatedDate DESC];
    
    Map<Id, Id> accToOpp = new Map<Id, Id>();
    for (Opportunity opp : othroppr) {
        if (!accToOpp.containsKey(opp.AccountId)) {
            accToOpp.put(opp.AccountId, opp.Id);
        }
    }
    
    List<Task> reassgntsk = new List<Task>();
    List<Task> tskdel = new List<Task>();
    
    for (Task tsk : reltTsk) {
        Id accId = oppToAcc.get(tsk.WhatId);
        if (accId != null && accToOpp.containsKey(accId)) {
            tsk.WhatId = accToOpp.get(accId);
            reassgntsk.add(tsk);
        } else {
            tskdel.add(tsk);
        }
    }
    
    if (!reassgntsk.isEmpty()) {        
        update reassgntsk;
    }
    
    if (!tskdel.isEmpty()) {
        delete tskdel;
    }
}