public class TriggerAssignmentF {
    public static void Triggassign(list<Contact>lstCot){ 
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
    
}