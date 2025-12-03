public class OpportunityHelperMain {
    
    public static void Trigassner4(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        Set<Id> accids = new Set<Id>();
        
        
        for (Opportunity opp : triggerNew) {
            if (opp.AccountId != null) {
                accids.add(opp.AccountId);
            }
        }
        
        
        List<Account> acclst = [SELECT Id, Is_Opp_Eligible_for_Close__c FROM Account WHERE Id IN :accids];
        
        
        for (Opportunity opp : triggerNew) { 
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
    
    
    
    
    public static void Trigassner8(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        For(Opportunity opp:triggerNew){
            if(opp.Amount!=null && opp.Amount>100000){
                opp.Description = 'Hot Opportunity';
            }
            break;
        }
    }
    
    
    
    public static void Trigassner12(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : triggerNew) {
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
    
    
    
    public static void Trigassner13(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){   
        Set<Id> delOppId = new Set<Id>();
        Map<Id, Id> oppToAcc = new Map<Id, Id>();
        
        for (Opportunity opp : triggerOld) {
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
    
    
    
    
    public static void TriggerAssn17(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        Set<Id> accIdSet = new Set<Id>();
        
        for (Opportunity opp : TriggerNew) {
            if (opp.AccountId != null) {
                accIdSet.add(opp.AccountId);
            }
        }
        
        if (accIdSet.isEmpty()) return;
        
        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, OwnerId, Owner.Email FROM Account WHERE Id IN :accIdSet]
        );
        
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        
        if (Trigger.isInsert) {
            for (Opportunity opp : TriggerNew) {
                if (opp.Amount != null && opp.Amount > 100000) {
                    Account acc = accountMap.get(opp.AccountId);
                    if (acc != null && acc.Owner != null && acc.Owner.Email != null) {
                        System.debug('>>> Sending email to: ' + acc.Owner.Email);
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(new String[] { acc.Owner.Email });
                        mail.setSubject('Opportunity Inserted: ' + opp.Name);
                        mail.setPlainTextBody('Opportunity ID"' + opp.Id + '" inserted with amount: ' + opp.Amount);
                        emailsToSend.add(mail);
                    }
                }
            }
        }
        
        if (Trigger.isUpdate) {
            for (Integer i = 0; i < TriggerNew.size(); i++) {
                Opportunity newOpp = TriggerNew[i];
                Opportunity oldOpp = TriggerOld[i];
                
                if (newOpp.Amount != null && newOpp.Amount > 100000 &&
                    (oldOpp.Amount == null || oldOpp.Amount <= 100000 || newOpp.Amount != oldOpp.Amount)) {
                        
                        Account acc = accountMap.get(newOpp.AccountId);
                        if (acc != null && acc.Owner != null && acc.Owner.Email != null) {
                            System.debug('>>> Sending update email to: ' + acc.Owner.Email);	
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setToAddresses(new String[] { acc.Owner.Email });
                            mail.setSubject('Opportunity Updated : ' + newOpp.Name);
                            mail.setPlainTextBody('Opportunity ID "' + newOpp.Id + '" updated with amount: ' + newOpp.Amount);
                            emailsToSend.add(mail);
                        }
                    }
            }
        }
        
        if (!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
    
    
    
    
}