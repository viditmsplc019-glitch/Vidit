public class ListContactrela {   
    public static void rv(){
        Set<Id> accountIds = new Set<Id>();

        List<Account> accountsWithContacts = [
            SELECT Id, Name,
                   (SELECT Id, FirstName, LastName, Email FROM Contacts)
            FROM Account LIMIT 10
        ];

        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
        for (Account acc : accountsWithContacts) {
            accountToContactsMap.put(acc.Id, acc.Contacts);
            System.debug('Account:' + acc.Name + ' has contacts:' + acc.Contacts);
        }
    }
}