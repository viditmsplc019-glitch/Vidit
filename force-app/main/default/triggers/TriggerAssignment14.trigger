trigger TriggerAssignment14 on Case (after delete) {
    Set<Id> accountIds = new Set<Id>();
    
    for (Case cse : Trigger.old) {
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
    
    for (Case cse : Trigger.old) {
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