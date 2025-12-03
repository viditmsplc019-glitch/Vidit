public class TriggerAssignmentB { 
    public static void Trigassn(List<Case> cc){ 
        Set<Id> acId = new Set<Id>();
        Set<Id> csId = new Set<Id>();
        for (Case cse : cc) {
            if (cse.AccountId != null) {
                acId.add(cse.AccountId);
            }
            csId.add(cse.Id);
        }
        List<Case> caseList = [SELECT Id, CaseNumber, Status, AccountId FROM Case WHERE Id IN :csId];
        
        List<Account> accUpdateList = new List<Account>();
        
        Set<Id> updatedAccIds = new Set<Id>();
        
        for (Case cse : caseList) {
            if (cse.AccountId != null && !updatedAccIds.contains(cse.AccountId)) {
                String caseInformation = 'Case Number - ' + cse.CaseNumber + ' and Status - ' + cse.Status;
                Account acc = new Account(Id = cse.AccountId);
                acc.Description = caseInformation;
                accUpdateList.add(acc);
                updatedAccIds.add(cse.AccountId); 
            }
        }
        
        List<Task> reltsk = [SELECT Id, Status, Description, WhatId FROM Task WHERE WhatId IN :csId];
        
        List<Task> updateTask = new List<Task>();
        
        for (Task tsk : reltsk) {
            
            for (Case cse : caseList) {
                
                if (tsk.WhatId == cse.Id) {
                   tsk.Status = cse.Status;
                    tsk.Description = 'Case Number - ' + cse.CaseNumber + 'and Status - ' + cse.Status;
                    updateTask.add(tsk);
                    break; 
                }
            }
        }
        if (!accUpdateList.isEmpty()) {
            update accUpdateList;
        }
        
        if (!updateTask.isEmpty()) {
            update updateTask;
        }
    }
}