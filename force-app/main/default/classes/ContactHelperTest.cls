@isTest
public class ContactHelperTest {
    @testSetup
    static void setupData(){
        Account ac1 = new Account(Name='testAccount1');
        insert ac1;
        Account ac2 = new Account(Name='testAccount2');
        insert ac2;
        Opportunity op1 = new Opportunity(name='opTest1',amount=1000,CloseDate=System.Today(),Stagename='Closed',type='New Customer');
        insert op1;
        Opportunity op2 = new Opportunity(name='opTest2',amount=1000,CloseDate=System.Today(),Stagename='Closed',type='New Customer',AccountId=ac1.Id);
        insert op2;
        Contact c1 = new Contact(LastName='testContact1',AccountId = ac1.id,Primary_Contact__c=true);
        insert c1;
        Contact c2 = new Contact(LastName='testContact2');
        insert c2;
        Contact c3 = new Contact(LastName='testContact3',AccountId = ac1.id,Primary_Contact__c=true);
        Contact c4 = new Contact(LastName='testContact3',AccountId = ac2.id);
        insert c4;
        string err = 'Only one Primary Contact is allowed per Account.';
        try{
            insert c3;
        }
        catch(exception e){
            System.assert(e.getMessage().Contains(err));
        }
        delete c4;
    }
    @isTest
    static void Test1(){
        Opportunity Opp = [select Id , Name , amount from opportunity where name = 'opTest1' LIMIT 1];
        opp.amount = 100010;
        update opp;
        Opportunity Opp12 = [select Id , Name , amount from opportunity where name = 'opTest2' LIMIT 1];
        delete opp12;
    }
}