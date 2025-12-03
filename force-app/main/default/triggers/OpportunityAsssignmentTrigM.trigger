trigger OpportunityAsssignmentTrigM on Opportunity (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityHandlerMain.beforeInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityHandlerMain.beforeUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        OpportunityHandlerMain.beforeDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityHandlerMain.afterInsert(trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityHandlerMain.afterUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        OpportunityHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        OpportunityHandlerMain.afterUndelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    
}