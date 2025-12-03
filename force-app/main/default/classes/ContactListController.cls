public class ContactListController {
    
    @AuraEnabled
    public static List<Contact> getContactList(List<Id> accountIds) {
        List<Contact> contactList = [SELECT Id, Name, Email, Phone, AccountId FROM Contact WHERE AccountId IN :accountIds];
        return contactList;
    }
    
    
    
    @AuraEnabled
    public static Map<String,String> saveContactList(List<Contact> contactList) {
        Map<String,String> resultMap = new Map<String,String>();
        try {
            update contactList;
            resultMap.put('status', 'success');
            resultMap.put('message', 'Contacts Updated Successfully');        
        }
        catch(Exception e) {
            resultMap.put('status', 'error');
            resultMap.put('message',e.getMessage());
        }
        return resultMap;
    }
    
     @AuraEnabled
    public static Map<String,String> deleteContactList(List<Id> contactIds) {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Id in :contactIds];
        Map<String,String> resultMap = new Map<String,String>();
        try {
            delete contactsToDelete;
            resultMap.put('status', 'success');
	    resultMap.put('message', 'Contacts Deleted Successfully');        
    	}
    	catch(Exception e) {
            resultMap.put('status', 'error');
       	    resultMap.put('message',e.getMessage());
    	}
        return resultMap;                
    }
        @AuraEnabled
    public static Map<String, String> createContactRecord(Contact newContact) {
        Map<String,String> resultMap = new Map<String,String>();
        try {
            insert newContact;
            resultMap.put('status', 'success');
            resultMap.put('message', 'Contact Inserted Successfully');        
        }
        catch(Exception e) {
            resultMap.put('status', 'error');
            resultMap.put('message',e.getMessage());
        }
        return resultMap;        
    }
}