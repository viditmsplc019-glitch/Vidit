public class TriggerHelperAccount {
    
     public Static Void TriggerAssn(list<Account>lstAccc){  
        Set<Id> accids = new Set<Id>();
        for (Account acc:lstAccc) {
            accids.add(acc.Id);
        
      }
        List<Case> closedCases = [SELECT Id, AccountId FROM Case WHERE AccountId IN :accids AND Status = 'Closed'];
        
        Map<Id, Integer> mapCnt = new Map<Id, Integer>();
        
        for (Case cas : closedCases) {
            if (mapCnt.containsKey(cas.AccountId)) {
                mapCnt.put(cas.AccountId, mapCnt.get(cas.AccountId) + 1);
            } else {
                mapCnt.put(cas.AccountId, 1);
            }
        }
        
        List<Account> lstupacc = new List<Account>();
        List<Account> lstacc = [SELECT Id, Rating FROM Account WHERE Id IN :accids];
        
        for (Account acc :lstacc ) {
            Integer count = mapCnt.containsKey(acc.Id) ?  mapCnt.get(acc.Id) : 0;
            String newRating;
            
            if (count <= 2) {
                newRating = 'Cold';
            } if(count>2) {
                newRating = 'Warm';
            }
            if(count>5) {
                newRating = 'Hot';
            }
            
            if (acc.Rating != newRating) {
                acc.Rating = newRating;
                lstupacc.add(acc);
            }
        }
        
        if (!lstupacc.isEmpty()) {
            update lstupacc;
        }
    }
    
    
    
    public static void Triggerassn9(list<Account> newAcc){
          For(Account acc:newAcc){
        if(acc.Copy_Billing_To_Shipping__c == True){
            acc.ShippingCountry = acc.BillingCountry;
            acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingPostalCode = acc.BillingPostalCode;
            acc.ShippingState = acc.BillingState ;
            
        }
    }
    
        
        
        
        
        
    }
    
    
    
    
    
    public static void TriggerHelper18(list<Account>lstAcct , map<Id,Account>mapAcc){
         Set<Id> accountIds = new Set<Id>();
    for (Account acc : lstAcct) {
        accountIds.add(acc.Id);
    }
    
    
    Map<Id, Account> oldAccountMap = new Map<Id, Account>([SELECT Id, Name, LastModifiedDate, Owner.Email  FROM Account  WHERE Id IN :accountIds]);
    
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    for (Account newAcc : lstAcct) {
        Account oldAcc = mapAcc.get(newAcc.Id);
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
    
    if (!emails.isEmpty() && !Test.isRunningTest()) {
        Messaging.sendEmail(emails);
    }
    }
    
    
    
    
    
}