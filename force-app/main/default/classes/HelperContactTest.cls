@isTest
public class HelperContactTest {
    
    @testSetup
    static void SetUpData() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        
        Contact c1 = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = acc.Id,
            Primary_Contact__c = true
        );
        insert c1;
        
        
        Contact c2 = new Contact(
            
            FirstName = 'Jane',
            LastName = 'Smith',
            AccountId = acc.Id,
            Primary_Contact__c = false
        );
        
        insert c2;
       
        
        
        Contact c6 = new Contact(
            
            FirstName = 'Jane',
            LastName = 'Smith'
        );
        insert c6;
        
        c2.Primary_Contact__c = true;
        
        
        
        
        
        
        try {
            update c2; 
            System.assert(false, 'Expected an error for multiple primary contacts.');
        } catch (DmlException e) {
            System.debug('Caught expected DML exception: ' + e.getMessage());
            System.assert(e.getMessage().contains('Not allowed More than one primaryContact'),
                          'Error message did not match expected.');
        }
    }
    
    
    @istest
    static void TestMethod1(){
        
    }
    
    
}