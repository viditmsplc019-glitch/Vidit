@isTest
public class caseHelperTest {
    @testSetup
    static void setupData(){
        
     Account acc = new Account(Name = 'Test Account');
        insert acc;
     Contact con1 = new Contact(LastName = 'TestContact', Email = 'viditmsplc019@gmail.com');
     insert con1;

        
        
        
        Case cs = new Case(
            ContactId = con1.Id,
            AccountId = acc.Id,
            Status = 'New',
            Origin = 'Phone',
            Subject = 'Test Case',
            SuppliedEmail = 'viditmsplc019@gmail.com'
        );
        insert cs;
        
        
        
        Case c2 = new Case(Status = 'Closed', Origin = 'Web', AccountId = acc.Id,SuppliedEmail = 'viditms9@gmail.com');
        insert c2;
        Case c3 = new Case(Status = 'Closed', Origin = 'Email', AccountId = acc.Id,ownerId = '005gK000004WItxQAG',SuppliedEmail = 'viditmsplc019@gmail.com');
        insert c3;

        
        Task t = new Task(
            WhatId = cs.Id,
            ownerId = '005gK000004WItxQAG',
            Subject = 'Related to Case',
            Status = 'Not Started',
            Priority = 'Normal'
        );
        insert t;

        
      
        
        
        
        
        
        
       
     
        delete c2;
    }
    
     
    
    
    @isTest
    static void testCaseDeletionCreatesTaskAndEmail() {
    case cc1 =    [ select Id , status from Case Where  Subject = 'Test Case' Limit 1];
    cc1.status = 'Not Started';
    update cc1;   
  

}
    
    
    
    
    
}