public with sharing class AccountContactController3 {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
    
    @AuraEnabled
    public static List<Contact> getContactsByAccount(Id accountId) {
        return [SELECT Id, Name, Email, Phone, LastModifiedDate FROM Contact WHERE AccountId = :accountId];
    }
    
    @AuraEnabled
    public static Contact getContactById(Id contactId) {
        return [SELECT Id, Name, Email, Phone, LastModifiedDate FROM Contact WHERE Id = :contactId LIMIT 6];
    }
    @AuraEnabled
    public static List<Contact> getLastModifiedContactsByAccount(Id accountId) {
        return [
            SELECT Id, Name, Email, Phone, LastModifiedDate
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY LastModifiedDate DESC
            LIMIT 5
        ];
    }
}