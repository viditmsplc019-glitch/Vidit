trigger TriggerAssignLead on Lead (before insert,before Update,before delete , after insert , after update , after delete , after undelete) {
    if(trigger.Isbefore){
        if(trigger.IsInsert || trigger.IsUpdate){
            LeadHandler.LeadhandAss(trigger.new);
        }
    }

}