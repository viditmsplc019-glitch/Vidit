trigger TriggerAssignment18 on Account (after update) {
    
    Set<Id> accountIds = new Set<Id>();
    for (Account acc : Trigger.new) {
        accountIds.add(acc.Id);
    }
    
    
    Map<Id, Account> oldAccountMap = new Map<Id, Account>([SELECT Id, Name, LastModifiedDate, Owner.Email  FROM Account  WHERE Id IN :accountIds]);
    
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    for (Account newAcc : Trigger.new) {
        Account oldAcc = Trigger.oldMap.get(newAcc.Id);
        Account accQuery = oldAccountMap.get(newAcc.Id);
        
        if (accQuery == null || accQuery.Owner == null || String.isBlank(accQuery.Owner.Email)) {
            continue; 
        }
        
        
        
        DateTime previousModifiedTime = accQuery.LastModifiedDate;
        
        
        List<Contact> updatedContacts = [SELECT Id, Name, LastModifiedDate FROM Contact WHERE AccountId = :newAcc.Id  AND LastModifiedDate > :previousModifiedTime];
        
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { accQuery.Owner.Email });
        email.setSubject('Account Update Notification');
        
        String body;
        if (!updatedContacts.isEmpty()) {
            List<String> contactNames = new List<String>();
            for (Contact con : updatedContacts) {
                contactNames.add(con.Name);
            }
            
            body = 'An account has been updated with the following contacts.\n\n';
            body += 'Account Name : ' + newAcc.Name + '\n';
            body += 'Account Id : ' + newAcc.Id + '\n';
            body += 'Contacts : ' + String.join(contactNames, ', ');
        } else {
            body = 'An account has been updated.\n\n';
            body += 'Account Name : ' + newAcc.Name + '\n';
            body += 'Account Id : ' + newAcc.Id;
        }
        
        
        email.setPlainTextBody(body);
        emails.add(email);
    }
    
    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
    }
}