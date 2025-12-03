public class CaseHelperMain {
    public static void Trigassn2(List<Case> triggerNew, Map<Id, Case> triggerNewMap, List<Case> triggerOld, Map<Id, Case> triggerOldMap){ 
        Set<Id> acId = new Set<Id>();
        Set<Id> csId = new Set<Id>();
        for (Case cse : triggerNew) {
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
    
    
     public static Void Trigassn11(List<Case> triggerNew, Map<Id, Case> triggerNewMap, List<Case> triggerOld, Map<Id, Case> triggerOldMap){
      List<Id> accIds = new List<Id>();
    for (Case cce : TriggerNew) {
        if (cce.AccountId != null && !accIds.contains(cce.AccountId)) {
            accIds.add(cce.AccountId);
        }
    }
    List<Case> latcase = [SELECT Id, CaseNumber, AccountId FROM Case WHERE AccountId IN :accIds ORDER BY CreatedDate DESC];
    
    List<Account> updtAcc= new List<Account>();
    
    List<Id> AccIdproc = new List<Id>();
    
    for (Case cce : latcase) {
        if (!AccIdproc.contains(cce.AccountId)) {
            Account Accd = new Account(Id = cce.AccountId,Latest_Case_Number__c = cce.CaseNumber);
            updtAcc.add(Accd);
            AccIdproc.add(cce.AccountId);
        }
    }
    
    if (!updtAcc.isEmpty()) {
        update updtAcc;
    }
        
    }
    
    
    
    
       public static void TriggAssn14(List<Case> triggerNew, Map<Id, Case> triggerNewMap, List<Case> triggerOld, Map<Id, Case> triggerOldMap){
        Set<Id> accountIds = new Set<Id>();
        
        for (Case cse : TriggerOld) {
            if (cse.AccountId!= null) {
                accountIds.add(cse.AccountId);
            }
        }
        
        if (accountIds.isEmpty()) return;
        
        
        List<Account> accountList = [SELECT Id, Name, OwnerId, Owner.Email FROM Account WHERE Id IN :accountIds];
        
        
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for (Account acc : accountList) {
            accountMap.put(acc.Id, acc);
        }
        
        List<Task> tskcre = new List<Task>();
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        
        for (Case cse : TriggerOld) {
            Account acc = accountMap.get(cse.AccountId);
            if (acc != null && acc.Owner != null && acc.Owner.Email!= null) {
                Task newTask = new Task( WhatId = acc.Id, Subject = 'Case deleted', Description = 'A case was deleted: Case Number ' + cse.CaseNumber, Priority = 'Normal', Status = 'Not Started');
                tskcre.add(newTask);
                
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {acc.Owner.Email});
                mail.setSubject('Case Deleted from Account: ' + acc.Name);
                mail.setPlainTextBody('A case (Case Number: ' + cse.CaseNumber + ') has been deleted from the account: ' + acc.Name + '.');
                emailsToSend.add(mail);
            }
        }
        
        if (!tskcre.isEmpty()) {
            insert tskcre;
        }
        
        if (!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
    
    
    
       public static void TriggAssn15(List<Case> triggerNew, Map<Id, Case> triggerNewMap, List<Case> triggerOld, Map<Id, Case> triggerOldMap){
        Set<String> suppliedEmails = new Set<String>();
        
        
        for (Case cce :triggerNew) {
            if (cce.SuppliedEmail != null && cce.ContactId == null) {
                suppliedEmails.add(cce.SuppliedEmail.trim().toLowerCase());
            }
        }
        
        if (suppliedEmails.isEmpty()) return;
        
        
        List<Contact> matchingContacts = [SELECT Id, Email FROM Contact WHERE Email IN :suppliedEmails];
        
        
        Map<String, Contact> emlconmp = new Map<String, Contact>();
        for (Contact con : matchingContacts) {
            emlconmp.put(con.Email.toLowerCase(), con);
        }
        
        
        List<Contact> contactsToCreate = new List<Contact>();
        Map<Id, Contact> caseToNewContact = new Map<Id, Contact>();
        
        for (Case cce : triggerNew) {
            if (cce.SuppliedEmail != null && cce.ContactId == null) {
                String email = cce.SuppliedEmail.trim().toLowerCase();
                
                if (emlconmp.containsKey(email)) {
                    
                    cce.ContactId = emlconmp.get(email).Id;
                } else {
                    
                    Contact newCon = new Contact(
                        LastName = 'Auto-Created from Case',
                        Email = email
                    );
                    contactsToCreate.add(newCon);
                    caseToNewContact.put(cce.Id, newCon);
                }
            }
        }
        
        
        if (!contactsToCreate.isEmpty()) {
            insert contactsToCreate;
            
            
            Integer i = 0;
            for (Case cce : triggerNew) {
                if (caseToNewContact.containsKey(cce.Id)) {
                    cce.ContactId = contactsToCreate[i].Id;
                    i++;
                }
            }
        }
        
    }
    

}