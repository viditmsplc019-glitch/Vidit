trigger TriggerAssignOpportunity on Opportunity (before insert, before Update , before delete , after insert , after Update , after delete ,After Undelete) {
    
    if(trigger.IsBefore){
        if(trigger.IsInsert || trigger.IsUpdate){
            OpportunityHandler.OpportunityHand4(trigger.new);
            OpportunityHandler.OpportunityHand8(trigger.new);
        }
    }
    if(trigger.IsAfter){
        if(trigger.IsInsert){
            //OpportunityHandler.OpportunityHand12(trigger.new);
        }
    }
    
    if(trigger.IsBefore){
        if(trigger.IsDelete){
            OpportunityHandler.OpportunityHand13(trigger.Old);
        }
    }
    
    
    
    
}