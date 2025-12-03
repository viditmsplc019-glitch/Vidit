trigger LeadAsssignmentTrigM on Lead (before insert,before Update, before delete,after insert , after update , after delete, after Undelete) {
      if(Trigger.isBefore && Trigger.isInsert){
        LeadHandlerMain.beforeInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        LeadHandlerMain.beforeUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        LeadHandlerMain.beforeDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        LeadHandlerMain.afterInsert(trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        LeadHandlerMain.afterUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        LeadHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        LeadHandlerMain.afterUnDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
}