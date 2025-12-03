trigger ContactAsssignmentTrigM on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(Trigger.isBefore && Trigger.isInsert){
        ContactHandlerMain.beforeInsert(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        ContactHandlerMain.beforeUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        ContactHandlerMain.beforeDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        ContactHandlerMain.afterInsert(trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        ContactHandlerMain.afterUpdate(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        ContactHandlerMain.afterDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        ContactHandlerMain.afterUnDelete(Trigger.New, Trigger.NewMap, Trigger.Old, Trigger.OldMap);
    }
}