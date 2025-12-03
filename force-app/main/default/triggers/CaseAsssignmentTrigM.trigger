trigger CaseAsssignmentTrigM on Case (before insert,before update,before delete,after insert,after update,after delete, after undelete) {
      if(Trigger.isBefore && Trigger.isInsert){
        CaseHandlerMain.beforeInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        CaseHandlerMain.beforeUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        CaseHandlerMain.beforeDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        CaseHandlerMain.afterInsert(trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        CaseHandlerMain.afterUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        CaseHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        CaseHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    
             
}