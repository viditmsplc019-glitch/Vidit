public with sharing class OpacCreatorController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts() {
        return [SELECT Id, Name FROM Product2 WHERE IsActive = true LIMIT 200];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<OpportunityproductAmountcalculation__c> getProductOpacs(Id productId) {
        if (productId == null) return new List<OpportunityproductAmountcalculation__c>();
        return [
            SELECT Id, Name, Product__r.Name, Min__c, Max__c, Price__c
            FROM OpportunityproductAmountcalculation__c
            WHERE Product__c = :productId
            ORDER BY Min__c ASC
        ];
    }
    @AuraEnabled
    public static Product2 createProduct(String name) {
        Product2 newProduct = new Product2(
            Name = name,
            IsActive = true
        );
        insert newProduct;
        return newProduct;
    }
    
    
    @AuraEnabled
    public static OpportunityproductAmountcalculation__c saveOpac(OpportunityproductAmountcalculation__c opac) {
        if (opac.Min__c == null || opac.Min__c <= 0) {
            throw new AuraHandledException('Min value must be greater than 0');
        }
        
        List<OpportunityproductAmountcalculation__c> existing = getProductOpacs(opac.Product__c);
        if (!existing.isEmpty()) {
            Decimal lastMax = existing[existing.size()-1].Max__c;
            if (opac.Min__c != lastMax + 1) {
                throw new AuraHandledException('New Min must start from ' + (lastMax + 1));
            }
        }
        
        insert opac;
        return opac;
    }
}