@isTest
public class DuplicateAccountTestClass {
    @testSetup
    Static void setupData(){
        Account a1 = new Account(Name = 'TestAcc');
        insert a1;
    }
    
    @isTest
    static void testAccountDuplicateTrigger(){
        Account a2 = new Account(Name = 'TestAcc');
        String expectedError = 'You cannot create the Duplicate Account';
        
        
        try{
            insert a2;
            System.assert(false , 'Expected an excepytion for duplicate Account , but none occured.');
            
        }Catch(Exception e){
            System.debug('Trigger Working');
            System.assert(e.getMessage().contains(expectedError),'Error message did not match expected.');
        }
    }
    

}