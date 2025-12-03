@isTest
public class HelperAccountTest {
    
    
    
    
    @isTest
    static void testMethod1() { 
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        
        
        Case c1 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 1');
        Case c2 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 2');
        Case c3 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 3');
        Case c4 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 4');
        Case c5 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 5');
        Case c6 = new Case(AccountId = acc.Id, Status = 'Closed', Origin = 'Phone', Subject = 'Case 6');
        
        insert new List<Case>{c1, c2, c3, c4, c5, c6};
            
            
            
            
            
            List<Account> accList = [SELECT Id, Name, Rating FROM Account WHERE Id = :acc.Id];
        TriggerHelperAccount.TriggerAssn(accList);
        
        
        Account updatedAcc = [SELECT Id, Rating FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Hot', updatedAcc.Rating);
    }
    
    
    @isTest 
    static void testMethod2(){
        Account acc = new Account();
        acc.Name = 'Test Account For testClass12';
        acc.Copy_Billing_To_Shipping__c = True;
        acc.BillingCountry = 'United States';
        acc.BillingState = 'Colorado';
        acc.BillingStreet = '123Salesforce';
        acc.BillingCity = 'Heaven';
        acc.BillingPostalCode = '1234789';
        Insert acc;
    }
    
    
    @isTest
    Static void testMethod3(){
        
        
        
      
        
        
        Account Acd = new Account();
        Acd.Name = 'Tetst Acc';
        Insert Acd;
        
        Account accd2 = new Account();
        accd2.Name='Accc 123';
        insert accd2;
        
        
        Contact Con = New Contact();
        Con.FirstName = 'Shivam';
        Con.LastName = 'Gupta';
        con.AccountId = accd2.Id;
        insert Con;
        Con.LastName = 'Naruto';
        update Con;
        Acd.Name = 'tstst Acc';
        Update Acd;
        
        con.FirstName ='Mahesh';
        update con;
        
    }
    
    
    
    
}