trigger TriggerAssignment17 on Opportunity (after insert, after update) {
    Set<Id> accIdSet = new Set<Id>();
    
    for (Opportunity opp : Trigger.new) {
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
        for (Opportunity opp : Trigger.new) {
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
        for (Integer i = 0; i < Trigger.new.size(); i++) {
            Opportunity newOpp = Trigger.new[i];
            Opportunity oldOpp = Trigger.old[i];
            
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