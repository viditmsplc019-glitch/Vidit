public with sharing class AccountContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 100];
    }


    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccount(Id accountId) {
        return [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
    }
}
