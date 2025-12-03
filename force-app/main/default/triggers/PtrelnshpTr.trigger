trigger PtrelnshpTr on Contact (After insert) {
    
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : Trigger.new) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }
    
    if (accountIds.isEmpty()) {
        System.debug('ID NOT FOUND');
    }
    
    
    List<Account> accountsWithContacts = [
        SELECT Id, Name,
        (SELECT Id, FirstName, LastName FROM Contacts)
        FROM Account
        WHERE Id IN :accountIds
    ];
    
    
    Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
    for (Account acc : accountsWithContacts) {
        accountToContactsMap.put(acc.Id, acc.Contacts);
        System.debug('Account:' + acc.Name + 'has contacts:' + acc.Contacts);
    }
    
    
}