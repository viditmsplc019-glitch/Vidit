@isTest
public class OpportunityHelperMainTest {
    @isTest
    static void OpportunityTestm() {
      
        Account acc = new Account(Name = 'Test Account', Is_Opp_Eligible_for_Close__c = true);
        insert acc;
        
       
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Probability = 80,
            Amount = 150000,
            AccountId = acc.Id
        );
        insert opp;
        

       
        opp.Amount = 200000;
        update opp;

        
        delete opp;
    }
}