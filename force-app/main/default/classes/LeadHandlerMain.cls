public class LeadHandlerMain {
      
    public static void beforeInsert(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
        LeadHelperMain.Triggasssin7(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeUpdate(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
        LeadHelperMain.Triggasssin7(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeDelete(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
        
    }
    public static void afterInsert(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
       
    }    
    public static void afterUpdate(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
       
    }
    public static void afterDelete(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
      
    }
    public static void afterUndelete(List<lead> triggerNew, Map<Id,lead> triggerNewMap, List<lead> triggerOld, Map<Id,lead> triggerOldMap){
        
    }

}