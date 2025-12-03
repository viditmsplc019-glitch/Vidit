public class AccountHandlerMain {
    
     public static void beforeInsert(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
       AccountHelperMain.Triggerassn9(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeUpdate(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
       AccountHelperMain.Triggerassn9(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeDelete(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
        
    }
    public static void afterInsert(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
       AccountHelperMain.TriggerAssn(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
       
        }    
    public static void afterUpdate(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
         AccountHelperMain.TriggerAssn(triggerNew, triggerNewMap, triggerOld, triggerOldMap);
        AccountHelperMain.TriggerSendContactUpdateEmail(triggerNew, triggerNewMap, triggerOld, triggerOldMap);
      }
    public static void afterDelete(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
      
    }
    public static void afterUndelete(List<Account> triggerNew, Map<Id,Account> triggerNewMap, List<Account> triggerOld, Map<Id,Account> triggerOldMap){
        
    }


}