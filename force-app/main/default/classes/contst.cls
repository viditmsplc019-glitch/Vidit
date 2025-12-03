@isTest
public class contst {
    @isTest
    static void TestOnlyOnePrimaryContactPerAccount() {
       
        Account acc = new Account(Name = 'Testing Contact Primary');
        insert acc;

        
        Contact c1 = new Contact(
            AccountId = acc.Id,
            LastName = 'Raven',
            FirstName = 'Shyam',
            Primary_Contact__c = true
        );

       
        Contact c2 = new Contact(
            AccountId = acc.Id,
            LastName = 'Triven',
            FirstName = 'Tetet',
            Primary_Contact__c = false
        );

        insert new List<Contact>{ c1, c2 };

        
        c2.Primary_Contact__c = true;

        Test.startTest();
        try {
            update c2;
            System.assert(false, 'Expected error was not thrown.');
        } catch (Exception e) {
            System.debug('Expected Exception: ' + e.getMessage());
            System.assert(
                e.getMessage().contains('Not allowed More than one primaryContact'),
                'Error message did not match expected.'
            );
        }
        Test.stopTest();
    }
}