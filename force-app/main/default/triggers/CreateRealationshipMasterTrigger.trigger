trigger CreateRealationshipMasterTrigger on Contact_Relationship__c (before update) {
    if(Trigger.isbefore && Trigger.isUpdate){
       
        UpdateCROwnerName.UpdateRelationshipNameByOwner(trigger.New);
            
    }
}