public class OpportunityHandlerMain {
    
    public static void beforeInsert(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        OpportunityHelperMain.Trigassner4(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        OpportunityHelperMain.Trigassner8(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeUpdate(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        OpportunityHelperMain.Trigassner4(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        OpportunityHelperMain.Trigassner8(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void beforeDelete(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        OpportunityHelperMain.Trigassner13(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }
    public static void afterInsert(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        OpportunityHelperMain.Trigassner12(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        OpportunityHelperMain.TriggerAssn17(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
    }    
    public static void afterUpdate(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        OpportunityHelperMain.TriggerAssn17(triggerNew,triggerNewMap,triggerOld,triggerOldMap);
        
    }
    public static void afterDelete(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        
    }
    public static void afterUndelete(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerNewMap, List<Opportunity> triggerOld, Map<Id, Opportunity> triggerOldMap){
        
    }
    
    
}