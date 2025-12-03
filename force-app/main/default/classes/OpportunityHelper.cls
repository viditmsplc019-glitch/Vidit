public class OpportunityHelper {
    
    public static void Trigassner4(list<Opportunity> lstOport){
        Set<Id> accids = new Set<Id>();
        
        
        for (Opportunity opp : lstOport) {
            if (opp.AccountId != null) {
                accids.add(opp.AccountId);
            }
        }
        
        
        List<Account> acclst = [SELECT Id, Is_Opp_Eligible_for_Close__c FROM Account WHERE Id IN :accids];
        
        
        for (Opportunity opp : lstOport) { 
            if (opp.AccountId != null) {
                for (Account acc : acclst) {
                    if (acc.Id == opp.AccountId && acc.Is_Opp_Eligible_for_Close__c == true) {
                        if (opp.Probability >= 70) {
                            opp.StageName = 'Closed Won'; 
                        }
                        break;
                    }
                }
            }
        }
        
    }
    
    
    
    public static void Trigassner8(list<Opportunity> lstOportun){
        For(Opportunity opp:lstOportun){
            if(opp.Amount!=null && opp.Amount>100000){
                opp.Description = 'Hot Opportunity';
            }
            break;
        }
    }
    
    
    
    
    
    public static void Trigassner12(list<Opportunity> lstOportunit){
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : lstOportunit) {
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
            update accLstUpdate;
        }
        
        
    }
    
    
    
    public static void Trigassner13(list<Opportunity> lstOportunitys){   
        Set<Id> delOppId = new Set<Id>();
        Map<Id, Id> oppToAcc = new Map<Id, Id>();
        
        for (Opportunity opp : lstOportunitys) {
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
    
    
    
    
    
    
}