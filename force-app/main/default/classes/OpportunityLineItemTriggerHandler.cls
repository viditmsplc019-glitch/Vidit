public class OpportunityLineItemTriggerHandler {
    public static void applyOpacPricing(List<OpportunityLineItem> newList) {
        Set<Id> productIds = new Set<Id>();
        for (OpportunityLineItem oli : newList) {
            if (oli.PricebookEntryId != null) {
                productIds.add(oli.PricebookEntry.Product2Id);
            }
        }

        if (productIds.isEmpty()) return;

        Map<Id, List<OpportunityproductAmountcalculation__c>> opacMap =
            new Map<Id, List<OpportunityproductAmountcalculation__c>>();

        for (OpportunityproductAmountcalculation__c opac : [
            SELECT Id, Product__c, Min__c, Max__c, Price__c
            FROM OpportunityproductAmountcalculation__c
            WHERE Product__c IN :productIds
        ]) {
            if (!opacMap.containsKey(opac.Product__c)) {
                opacMap.put(opac.Product__c, new List<OpportunityproductAmountcalculation__c>());
            }
            opacMap.get(opac.Product__c).add(opac);
        }

        for (OpportunityLineItem oli : newList) {
            Id productId = oli.PricebookEntry.Product2Id;
            if (opacMap.containsKey(productId)) {
                for (OpportunityproductAmountcalculation__c rule : opacMap.get(productId)) {
                    if (oli.Quantity >= rule.Min__c && oli.Quantity <= rule.Max__c) {
                        oli.UnitPrice = rule.Price__c;
                        oli.TotalPrice = oli.Quantity * rule.Price__c;
                        break;
                    }
                }
            }
        }
    }
}