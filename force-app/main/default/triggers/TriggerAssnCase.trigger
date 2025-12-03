trigger TriggerAssnCase on Case (before insert,before Update , before delete , after insert , after Update , after delete , after undelete) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.IsUpdate){
            caseHandler.AssHandler2(trigger.new);
        }
    }
    
    if(trigger.IsAfter){
        if(trigger.isInsert){
            caseHandler.AssHandler11(trigger.new);
        }
    }
    
    if(trigger.IsAfter){
        if(trigger.IsDelete){
            caseHandler.AssHandler14(trigger.old);
        }
    }
    if(trigger.IsBefore){
        if(trigger.isInsert){
            caseHandler.AssHandler15(trigger.new);
        }
    }

}