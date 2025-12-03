trigger AccountAsssignmentTrigM on Account (before insert,before update,before delete,after insert ,after update, after delete,after undelete) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        AccountHandlerMain.beforeInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        AccountHandlerMain.beforeUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        AccountHandlerMain.beforeDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        AccountHandlerMain.afterInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
  if (Trigger.isAfter && Trigger.isUpdate) {
      System.debug('hi');
        AccountHandlerMain.afterUpdate(trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        AccountHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        AccountHandlerMain.afterUnDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }

}