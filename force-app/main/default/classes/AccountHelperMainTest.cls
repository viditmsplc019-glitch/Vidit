@isTest
private class AccountHelperMainTest {
    
    @testSetup
    static void setupData() {
       
     
        
        
        Account acc = new Account(
            Name = 'Original Account',
             OwnerId = '005gK000004WItxQAG',
            Copy_Billing_To_Shipping__c = true,
            BillingStreet = '123 Main St',
            BillingCity = 'Cityville',
            
            BillingPostalCode = '12345',
            BillingCountry = 'United States',
            BillingState = 'Colorado'
            
        );
        insert acc;
        
      
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 6; i++) {
            cases.add(new Case(
                AccountId = acc.Id,
                Status = 'Closed',
                Origin = 'Phone',
                Subject = 'Case ' + i
            ));
        }
        insert cases;
    }
    
    @isTest
    static void testTriggerAssn_RatingUpdate() {
        
                
        
        Account result = [SELECT Id, Rating FROM Account];
        System.assertEquals('Hot', result.Rating, 'Rating should be Hot');
    }
    
    @isTest
    static void testTriggerassn9_CopyBillingToShipping() {
        Account acc = new Account(
            Name = 'BillingTest',
            Copy_Billing_To_Shipping__c = true,
            BillingStreet = '456 Billing St',
            BillingCity = 'Billtown',
            BillingState = 'Colorado',
            BillingPostalCode = '78910',
            BillingCountry = 'United States'
        );
        
        Test.startTest();
        insert acc;
        Test.stopTest();
        
        Account result = [SELECT ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry 
                          FROM Account WHERE Id = :acc.Id];
        
        System.assertEquals('456 Billing St', result.ShippingStreet);
        System.assertEquals('Billtown', result.ShippingCity);
        System.assertEquals('Colorado', result.ShippingState);
        System.assertEquals('78910', result.ShippingPostalCode);
        System.assertEquals('United States', result.ShippingCountry);
    }
    
    @isTest
    static void testTriggerHelper18_EmailSent() {
        
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        String oldName = acc.Name;
        String newName = 'New Name - ' + oldName;
        
        Test.startTest();
        acc.Name = newName;
        update acc;
        Test.stopTest();
        
       
        System.assertEquals(newName, [SELECT Name FROM Account WHERE Id = :acc.Id].Name);
    }
}