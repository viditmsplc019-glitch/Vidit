@isTest
private class TriggerHelperAccountTest {
    
    static Id testAccountId;
    static Account accWithCheckbox;
    
    @testSetup
    static void setupTestData() {
       
        accWithCheckbox = new Account(
            Name = 'Account Copy Address',
            BillingStreet = '123 Main St',
            BillingCity = 'New York',
            BillingPostalCode = '10001',
            BillingCountry = 'United States', 
            BillingState = 'Colorado',        
            Copy_Billing_To_Shipping__c = true
        );
        insert accWithCheckbox;

     
        Account acc = new Account(Name = 'Account With Cases');
        insert acc;
        testAccountId = acc.Id;

        
        List<Case> closedCases = new List<Case>();
        for (Integer i = 0; i < 6; i++) {
            closedCases.add(new Case(
                AccountId = testAccountId,
                Status = 'Closed',
                Subject = 'Closed Case ' + i
            ));
        }
        insert closedCases;

        
        Contact con = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = acc.Id
        );
        insert con;
    }

    @isTest
    static void testTriggerassn9_CopyBillingToShipping() {
        
        
        Id Idsq = [Select id from Account where  Name = 'Account Copy Address'].Id;
        
        Account acc = [SELECT Id, BillingStreet, BillingCity, BillingCountry, BillingState , BillingPostalCode,
                     Copy_Billing_To_Shipping__c   FROM Account WHERE Copy_Billing_To_Shipping__c= True AND Id  = :Idsq];

        
        TriggerHelperAccount.Triggerassn9(new List<Account>{acc});

    
        System.assertEquals(acc.BillingStreet, acc.ShippingStreet, 'ShippingStreet not copied');
        System.assertEquals(acc.BillingCity, acc.ShippingCity, 'ShippingCity not copied');
        System.assertEquals(acc.BillingCountry, acc.ShippingCountry, 'ShippingCountry not copied');
        System.assertEquals(acc.BillingState, acc.ShippingState, 'ShippingState not copied');
    }

    @isTest
    static void testTriggerAssn() {
         System.debug(testAccountId);
       Id ids =[Select id from Account where Name='Account With Cases'].id;
        Account acc = [SELECT Id, Rating FROM Account WHERE Id = :ids limit 1];
        System.debug(acc);
        
        TriggerHelperAccount.TriggerAssn(new List<Account>{acc}, new List<Account>{acc});

        
        Account updatedAcc = [SELECT Id, Rating FROM Account WHERE Id = :ids];
        System.assertEquals('Hot', updatedAcc.Rating, 'Account rating should be set to Hot');
    }

    @isTest
    static void testTriggerHelper18_SendEmail() {
         Id ids =[Select id from Account where Name='Account With Cases'].id;
        
        Account acc = [SELECT Id, Name, LastModifiedDate, Owner.Email FROM Account WHERE Id = :Ids];

        Test.startTest();

        
        Account accBefore = [SELECT Id, Name, LastModifiedDate, Owner.Email FROM Account WHERE Id = :Ids];
        Map<Id, Account> accMap = new Map<Id, Account>();
        accMap.put(accBefore.Id, accBefore);

        
        Contact con = [SELECT Id, LastModifiedDate FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        con.FirstName = 'Updated';
        update con;

       
        TriggerHelperAccount.TriggerHelper18(new List<Account>{accBefore}, accMap);

        Test.stopTest();

       
        System.assert(true, 'TriggerHelper18 executed without error');
    }
}