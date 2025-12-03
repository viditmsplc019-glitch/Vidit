public class HelperclassContact {
    
    public static void Triggerassn3(list<Contact> newCons){
        
        Set<Id> accid = new Set<Id>();
        
        for (Contact con : newCons) {
            if (con.Primary_Contact__c ){ 
                if(con.AccountId != null) {
                    accid.add(con.AccountId);
                }
            }
        }
        
        
        
        List<Contact> oldprimarycon = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accId AND Primary_Contact__c = true];
        
        for (Contact newcon :newCons) {
            if (newCon.Primary_Contact__c ){ 
                if(newCon.AccountId != null) {
                    for (Contact oldcon : oldprimarycon) {
                        
                        if (oldcon.AccountId == newCon.AccountId){ 
                            if(oldcon.Id != newCon.Id) {
                                newCon.addError('Not allowed More than one primaryContact');
                                break; 
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    public static void Triggassign6(list<Contact>lstCot){ 
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : lstCot) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        List<Account> accounts = [SELECT Id, Phone, Fax FROM Account WHERE Id IN :accountIds];
        for (Contact con : lstCot) {
            if (con.AccountId != null) {
                for (Account acc : accounts) {
                    if (con.AccountId == acc.Id) {
                        con.Phone = acc.Phone;
                        con.Fax = acc.Fax;
                        break; 
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    public static void Trigassigw5(list<Contact>lstcont){
        
        List<Account> newAccounts = new List<Account>();
        List<Integer> noofCon = new List<Integer>();
        
        
        for (Integer i = 0; i < lstcont.size(); i++) {
            Contact contt = lstcont[i];
            if (contt.AccountId == null) {
                Account acc = new Account();
                acc.Name = contt.LastName + ' Account'; 
                newAccounts.add(acc);
                noofCon.add(i); 
            }
        }
        
        
        if (!newAccounts.isEmpty()) {
            insert newAccounts;
            
            
            for (Integer j = 0; j < noofCon.size(); j++) {
                Integer index = noofCon[j];
                lstcont[index].AccountId = newAccounts[j].Id;
            }
        }
    }
    
    
    
    
    
    
    
    public static void updateAccountDescriptions16(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) return;
        
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Description FROM Account WHERE Id IN :accountIds]);
        
        List<Contact> contactList = [SELECT Id, Name, CreatedDate, AccountId FROM Contact WHERE AccountId IN :accountIds];
        
        Map<Id, List<Contact>> accToContacts = new Map<Id, List<Contact>>();
        for (Contact con : contactList) {
            if (!accToContacts.containsKey(con.AccountId)) {
                accToContacts.put(con.AccountId, new List<Contact>());
            }
            accToContacts.get(con.AccountId).add(con);
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Id accId : accMap.keySet()) {
            Account acc = accMap.get(accId);
            List<Contact> contacts = accToContacts.get(accId);
            if (contacts != null && !contacts.isEmpty()) {
                List<String> descLines = new List<String>();
                for (Contact c : contacts) {
                    descLines.add(c.Name + ' - ' + String.valueOf(c.CreatedDate.date()));
                }
                acc.Description = String.join(descLines, ', ');
            } else {
                acc.Description = null;
            }
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    
    
    
    
    
    
    
    
    public static void updateAccountDescriptions(Set<Id> accountIds) {
        Map<Id, Account> accMap = new Map<Id, Account>(
            [SELECT Id, Description FROM Account WHERE Id IN :accountIds]
        );
        
        
        List<Contact> relatedContacts = [SELECT Id, Name, CreatedDate, AccountId FROM Contact WHERE AccountId IN :accountIds];
        
        
        Map<Id, List<Contact>> accToContacts = new Map<Id, List<Contact>>();
        for (Contact con : relatedContacts) {
            if (!accToContacts.containsKey(con.AccountId)) {
                accToContacts.put(con.AccountId, new List<Contact>());
            }
            accToContacts.get(con.AccountId).add(con);
        }
        
        List<Account> accToUpdate = new List<Account>();
        
        for (Id accId : accMap.keySet()) {
            Account acc = accMap.get(accId);
            List<Contact> cons = accToContacts.get(accId);
            
            if (cons != null && !cons.isEmpty()) {
                List<String> descParts = new List<String>();
                for (Contact c : cons) {
                    descParts.add(c.Name + ' - ' + String.valueOf(c.CreatedDate.date()));
                }
                acc.Description = String.join(descParts, ', ');
            } else {
                acc.Description = null;
            }
            
            accToUpdate.add(acc);
        }
        
        if (!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
    
    
    
    
    public static void triggerAsnn19(list<Contact>lstcons){
        Set<Id> accountIds = new Set<Id>();
    for (Contact con : lstcons) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }
    
    if (accountIds.isEmpty()) return;
    
    list<Opportunity>opplstAcc = [SELECT Id, Amount, AccountId  FROM Opportunity  WHERE AccountId IN :accountIds];
    Map<Id, List<Opportunity>> accountOppsMap = new Map<Id, List<Opportunity>>();
    for(Opportunity opp : opplstAcc) {
        if (!accountOppsMap.containsKey(opp.AccountId)) {
            accountOppsMap.put(opp.AccountId, new List<Opportunity>());
        }
        accountOppsMap.get(opp.AccountId).add(opp);
    }
    
    
    List<Account> accountsToUpdate = new List<Account>();
    List<Opportunity> newOpportunities = new List<Opportunity>();
    
    for (Id accId : accountIds) {
        if (accountOppsMap.containsKey(accId)	) {
            
            Decimal totalAmount = 0;
            for (Opportunity opp : accountOppsMap.get(accId)) {
                if (opp.Amount != null) {
                    totalAmount = totalAmount + opp.Amount;
                }
            }
            accountsToUpdate.add(new Account(
                Id = accId,
                Description = 'Total Opportunity Amount: ' + String.valueOf(totalAmount)
            ));
        } else {
            
            newOpportunities.add(new Opportunity( Name = 'New Opportunity from Contact', StageName = 'Prospecting', CloseDate = System.today().addDays(30), Amount = 1000,  AccountId = accId  ));
        }
    }
    
    
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
    
    if (!newOpportunities.isEmpty()) {
        insert newOpportunities;
    }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}