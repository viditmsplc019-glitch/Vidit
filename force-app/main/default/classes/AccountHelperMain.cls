public class AccountHelperMain{
    
    public Static Void TriggerAssn(List<Account> triggerNew, Map<Id, Account> triggerNewMap, List<Account> triggerOld, Map<Id, Account> triggerOldMap){  
        Set<Id> accids = new Set<Id>();
        for (Account acc:triggerNew) {
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
    
    
    
    
    public static void Triggerassn9(List<Account> triggerNew, Map<Id, Account> triggerNewMap, List<Account> triggerOld, Map<Id, Account> triggerOldMap){
        For(Account acc:triggerNew){
            if(acc.Copy_Billing_To_Shipping__c == True){
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState ;
                
            }
        }
        
    }
    
    
    
    
    public static void TriggerSendContactUpdateEmail(List<Account> triggerNew, Map<Id, Account> triggerNewMap, List<Account> triggerOld, Map<Id, Account> triggerOldMap) {
        Set<Id> accIds = new Set<Id>();
        for (Account acc : triggerNew) {
            accIds.add(acc.Id);
        }

        List<Contact> relatedContacts = [SELECT Id, Name, AccountId, LastModifiedDate FROM Contact WHERE AccountId IN :accIds];
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        for (Account acc : triggerNew) {
            Account oldAcc = triggerOldMap.get(acc.Id);
            if (oldAcc == null || acc.LastModifiedDate == null) continue;

            List<String> updatedContactNames = new List<String>();
            for (Contact con : relatedContacts) {
                if (con.AccountId == acc.Id &&
                    con.LastModifiedDate > oldAcc.LastModifiedDate &&
                    con.LastModifiedDate <= acc.LastModifiedDate) {
                    updatedContactNames.add(con.Name);
                }
            }

            if (acc.OwnerId != null) {
                User owner = [SELECT Id, Email FROM User WHERE Id = :acc.OwnerId LIMIT 1];
                if (owner.Email != null) {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] { owner.Email });
                    mail.setSubject('Account Updated: ' + acc.Name);
                    String body = 'Account Name : ' + acc.Name + '\n' +
                                  'Account Id : ' + acc.Id + '\n';

                    if (!updatedContactNames.isEmpty()) {
                        body += 'An account has been updated with the following contacts.\n' +
                                'Contacts : ' + String.join(updatedContactNames, ', ');
                    } else {
                        body += 'An account has been updated.\n(No contact was modified)';
                    }

                    mail.setPlainTextBody(body);
                    emailsToSend.add(mail);
                }
            }
        }

        if (!emailsToSend.isEmpty()) {
            //Messaging.sendEmail(emailsToSend);
        }
    }
    
    
}