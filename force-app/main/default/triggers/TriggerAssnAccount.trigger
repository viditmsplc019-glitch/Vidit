trigger TriggerAssnAccount on Account (before insert,before update , before delete , after insert , after update , after delete, after Undelete) {
    
    if(Trigger.isAfter){
        if(trigger.IsInsert || trigger.IsUpdate || trigger.Isdelete){
             AccountHandlerAssn.Triggerassnhand1(trigger.new);
        }
    }
    
    
    if(Trigger.Isbefore){
        If(Trigger.IsInsert || Trigger.IsUpdate){
            AccountHandlerAssn.Triggeraassnhand2(Trigger.new);
        }
    }
    
    
    if(Trigger.isAfter){
        list<Account> newmainlst = trigger.new;
        map<Id,Account> mainMapAcc = trigger.oldMap;
        if(Trigger.IsUpdate){
            AccountHandlerAssn.Triggerassnhand18(newmainlst , mainMapAcc);
        }
    }
    
    

}