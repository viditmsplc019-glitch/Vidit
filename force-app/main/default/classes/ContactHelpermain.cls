public class ContactHelpermain {
    
    public static void onePrimaryContact(List<Contact> triggerNew, Map<Id, Contact> triggerNewMap, List<Contact> triggerOld, Map<Id, Contact> triggerOldMap){
        Set<Id> accId = new Set<Id>();
        for(Contact c : triggerNew){
            if(c.Primary_Contact__c == true && c.AccountId != null){
                accId.add(c.accountId);
            }
        }
        Map<Id, Contact> accWithPrimaryCon = new Map<Id, Contact>();
        if(!accId.isEmpty()){
            List<Contact> primaryConList = [Select Id, AccountId From Contact Where Account.Id IN: accId AND Primary_Contact__c = True];
            for(Contact con : primaryConList){
                accWithPrimaryCon.put(con.AccountId,con);
            }
        }
        for (Contact con : triggerNew) {
            if (con.Primary_Contact__c && con.AccountId != null) {
                Contact existingPrimary = accWithPrimaryCon.get(con.AccountId);
                if (existingPrimary != null && existingPrimary.Id != con.Id) {
                    con.addError('Only one Primary Contact is allowed per Account.');
                }
            }
        }
    }
    
    public static void accountCreationOnContactCreation(List<Contact> triggerNew, Map<Id, Contact> triggerNewMap, List<Contact> triggerOld, Map<Id, Contact> triggerOldMap){
        List<Account> acc = new List<Account>();
        Account a = new Account();
        for(Contact c : triggerNew){
            String name = c.FirstName + c.LastName;
            a.name = name;
            a.Email__c = 'xyz@gmail.com';
            acc.add(a);
        }
        insert acc;
    }
    
    public static void synchronizeAccountOnContact(List<Contact> triggerNew, Map<Id, Contact> triggerNewMap, List<Contact> triggerOld, Map<Id, Contact> triggerOldMap){
        Set<Id> accId = new Set<Id>();
        for(Contact c : triggerNew){
            if(c.AccountId != null){
                accId.add(c.AccountId);
            }
        }
        if(!accId.isEmpty()){
            Map<Id, Contact> contactMap = new Map<Id, Contact>();
            List<Contact> conList = [Select Id, AccountID, Phone, Fax From Contact Where AccountId IN: accID];
            for(Contact c : conList){
                if(!contactMap.containsKey(c.AccountId)){
                    contactMap.put(c.AccountId, c);
                }
            }
            List<Account> accToUpdate = new List<Account>();
            for(Contact c : triggerNew){
                for(Id accountId : contactMap.keySet()){
                    Account acc = new Account();
                    acc.Id = accountId;
                    acc.Fax = c.Fax;
                    acc.Phone = c.Phone;
                    accToUpdate.add(acc);
                }
            }
            if(!accToUpdate.isEmpty()){
                update accToUpdate;
            }
        }
    }
    
    public static void updateAccountDescriptionOnContact(List<Contact> triggerNew, Map<Id, Contact> triggerNewMap, List<Contact> triggerOld, Map<Id, Contact> triggerOldMap){
        Set<Id> accId = new Set<Id>();
        if(trigger.isInsert || trigger.isUpdate){
            for(Contact c : triggerNew){
                if((c.AccountId) != null){
                    accId.add(c.AccountId);
                }
            }
        }
        if(trigger.isDelete){
            for(Contact c : triggerOld){
                if((c.AccountId) != null){
                    accId.add(c.AccountId);
                }
            }
        }
        Map<Id, List<Contact>> accConMap = new Map<Id, List<Contact>>();
        if(!accId.isEmpty()){
            List<Account> accList = [SELECT Id, Name, (SELECT Id, Name, CreatedDate FROM Contacts) FROM Account WHERE Id IN: accId];
            for (Account acc : accList) {
                accConMap.put(acc.Id, acc.Contacts);
            }
        }
        List<Account> accToUpdate = new List<Account>();
        for(Id accountId : accId) {
            Account a = new Account(Id = accountId);
            String Description = '';
            for(Contact con : accConMap.get(accountId)) {
                Description += con.Name + ' ' + con.CreatedDate + '\n';
            }
            a.Description = Description;
            accToUpdate.add(a);
        }
        if(!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
    
    public static void updateAccountDescriptionWithOpp(List<Contact> triggerNew, Map<Id, Contact> triggerNewMap, List<Contact> triggerOld, Map<Id, Contact> triggerOldMap){
        Set<Id> accId = new Set<Id>();
        for(Contact c : triggerNew){
            if(c.AccountId != null){
                accId.add(c.AccountId);
            }
        }
        List<Account> updatedAcc = new List<Account>();
        List<Opportunity> oppList = [Select Id, AccountId, Amount From Opportunity Where AccountId IN: accID];
        Decimal sum = 0;
        for(Opportunity opp : oppList){
            sum += opp.Amount;
        }
        Map<Id, Decimal> accOppAmountMap = new Map<Id, Decimal>();
        for(Opportunity opp : oppList){
            accOppAmountMap.put(opp.AccountId, sum);
        }
        for(Id accountId : accOppAmountMap.keySet()){
            Account acc = new Account();
            acc.Id = accountId;
            System.debug(accountId);
            acc.Description = 'Total Amount : ' + sum;
            System.debug(acc.Description);
            updatedAcc.add(acc);
        }
        List<Opportunity> updatedOpp = new List<Opportunity>();
        List<Account> accOpp = [Select Id, Name,(Select Id From Opportunities) From Account Where Id IN: accId];
        for(Account acc: accOpp){
            
            
            if(acc.Opportunities.size() == 0){
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = 'OppByAcc';
                opp.StageName = 'Prospecting';
                opp.Amount = 10000;
                opp.CloseDate = System.Today();
                opp.Type = 'New Customer';
                updatedOpp.add(opp);
            }
        }
        if(!updatedAcc.isEmpty()){
            update updatedAcc;
        }
        if(!updatedOpp.isEmpty()){
            insert updatedOpp;
        }
    }
    
    
    
    
}