public class ContactHandler {
    
    
    public static Void Conthandass3(list<Contact>newLstCon){
        HelperclassContact.Triggerassn3(newLstCon);
    }
    
    
    public static Void Conthandass5(list<Contact>newLstCont){
        HelperclassContact.Trigassigw5(newLstCont);
    }
    
    public static Void Conthandass6(list<Contact>newLstConta){
        HelperclassContact.Triggassign6(newLstConta);
    }
    
    public static void handleAfterInsert(List<Contact> newContacts) {
        Set<Id> accIds = new Set<Id>();
        for (Contact con : newContacts) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        HelperclassContact.updateAccountDescriptions16(accIds);
    }
    
    public static void handleAfterUpdate(List<Contact> newContacts, List<Contact> oldContacts) {
        Set<Id> accIds = new Set<Id>();
        for (Contact con : newContacts) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        for (Contact con : oldContacts) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        HelperclassContact.updateAccountDescriptions16(accIds);
    }
    
    public static void handleAfterDelete(List<Contact> oldContacts) {
        Set<Id> accIds = new Set<Id>();
        for (Contact con : oldContacts) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        HelperclassContact.updateAccountDescriptions16(accIds);
    }
    
    
    
    
    
    

    public static void handleAfter(list<Contact>lstcon, list<Contact>lstcons) {
        Set<Id> accountIds = new Set<Id>();

       
            for (Contact cons: lstcon) {
                if (cons.AccountId != null) {
                    accountIds.add(cons.AccountId);
                }
            }
        

        
            for (Contact cons: lstcons) {
                if (cons.AccountId != null) {
                    accountIds.add(cons.AccountId);
                }
            }
        

        if (!accountIds.isEmpty()) {
            HelperclassContact.updateAccountDescriptions(accountIds);
        }
    }
    
    
    public static void AfterInsertHand19(list<Contact>newlstcons){
        HelperclassContact.triggerAsnn19(newlstcons);
    }


}