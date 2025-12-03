@isTest
public class AccountHelperTest {
    @testSetup
    static void setupdata(){
        
        
        Account a1 = new Account(Name = 'TestAccount', Number_of_Locations__c = 4, Copy_Billing_To_Shipping__c = true); 
        insert a1; 
        Case cs = new Case( AccountId = a1.Id, Status = 'Closed', Origin = 'Phone',Subject = 'Test Case');
        insert cs;
   
        Account a2 = new Account(Name = 'TestAccount2', OwnerId = '005gK000004WItx'); 
        insert a2; 
           Case cs1 = new Case(
            
            AccountId = a1.Id,
            Status = 'Closed',
            Origin = 'Phone',
            Subject = 'Test ccs'
            
        );
        insert cs1;
       
        Account a4 = new Account(Name = 'TestAccount'); 
        Opportunity o1 = new Opportunity(Name = 'TestOpp', Amount = 1000, CloseDate = System.Today(), 
                                         StageName = 'Closed', Type = 'New Customer', AccountId = a2.Id); 
        insert o1; string err = 'error'; 
        try{ 
            delete a2; 
            insert a4; 
        } catch(Exception e){ 
            System.assert(e.getMessage().contains(err)); 
        } 
    } 
    @isTest static void testAccountHelper(){ 
        //string err = 'You can not Create Duplicate Accounts'; 
        //Account a = [Select Id From Account Where Name = 'Mr.TestAccount3' LIMIT 1]; 
        //try{ 
        // delete a; 
        //} catch(Exception e){ 
        // System.assert(e.getMessage().contains(err));
        // }
         Account a3 = new Account(Name = 'TestAccount3', OwnerId = '005gK000004WItxQAG'); 
        insert a3; 
        Contact con1 = new Contact(LastName = 'Ghop ghop',accountId = a3.Id);
        insert con1;
        Account acc2 = new account(Name = 'testing hard' );
        con1.AccountId = acc2.id;
        insert acc2;
        
        Account Acc = [select id , Name from Account where Name = 'TestAccount' Limit 1];
        Acc.Number_of_Locations__c = 6;
        update Acc;
        
        acc2.Name = 'Testing Easy';
        update acc2;
         Account acc3 = new Account(Name = 'Test Account', OwnerId = '005gK000004WItxQAG');
        insert acc3;
        acc3.Name = 'Updated Account';
        update acc3;
    }
    
    
    
    
    @isTest
    static void testTriggerHelper18Simple() {
        Account acc = new Account(Name = 'Original Account');
        insert acc;

        acc.Name = 'Updated Account';
        update acc;
        
        Account Acc2 = [select id , Name from Account where Name = 'TestAccount' Limit 1];
        Acc2.Number_of_Locations__c = 6;
        update Acc2;
        contact con12 = new Contact(Lastname = 'Ghopghop Gaurav',AccountId=Acc2.id);
        insert con12;
        
        
        Acc2.Name = 'Ghopghu';
        update Acc2;
        
        
    }
}