public class ContactHandlerMain {
    
    
    public static void beforeInsert(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        ContactHelpermain.onePrimaryContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeUpdate(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        ContactHelpermain.onePrimaryContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeDelete(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        
    }
    public static void afterInsert(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        ContactHelpermain.accountCreationOnContactCreation(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.synchronizeAccountOnContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.updateAccountDescriptionOnContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.updateAccountDescriptionWithOpp(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }    
    public static void afterUpdate(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        ContactHelpermain.accountCreationOnContactCreation(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.synchronizeAccountOnContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.updateAccountDescriptionOnContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        ContactHelpermain.updateAccountDescriptionWithOpp(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterDelete(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        ContactHelpermain.updateAccountDescriptionOnContact(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterUndelete(List<Contact> triggerNew, Map<Id,Contact> triggerNewMap, List<Contact> triggerOld, Map<Id,Contact> triggerOldMap){
        
    }


}