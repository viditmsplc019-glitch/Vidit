trigger TriggAssnCandidate on Candidate__c (before insert , before Update , before Delete , after Insert , after Update , after delete , after Undelete) {
    if(Trigger.IsAfter){
        if(Trigger.IsInsert || Trigger.IsUpdate){
            CandidateHandler.AfterInsertDelete20(trigger.new);
        }
    }
}