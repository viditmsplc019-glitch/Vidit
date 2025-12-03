trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            OpportunityLineItemTriggerHandler.applyOpacPricing(Trigger.new);
        }
    }
}