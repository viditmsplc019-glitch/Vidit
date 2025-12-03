public class CaseHandlerMain {
     
    public static void beforeInsert(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
        CaseHelperMain.TriggAssn15(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeUpdate(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
    
    }
    public static void beforeDelete(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
        
    }
    public static void afterInsert(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
        CaseHelperMain.Trigassn2(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        CaseHelperMain.Trigassn11(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }    
    public static void afterUpdate(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
        CaseHelperMain.Trigassn2(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
         }
    public static void afterDelete(List<case>triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case>  triggerOldMap){
        CaseHelperMain.TriggAssn14(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterUndelete(List<case> triggerNew, Map<Id,case> triggerNewMap, List<Case> triggerOld, Map<Id,Case> triggerOldMap){
        
    }


}