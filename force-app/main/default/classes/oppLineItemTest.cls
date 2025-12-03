@isTest
public class oppLineItemTest {
    @testSetup
    static void setupData(){
        PriceBook2 stpb = new PriceBook2(Id = Test.getStandardPriceBookId(), IsActive = true);
        update stpb;
        PriceBook2 pb = new PriceBook2(Name = 'testPB', IsActive = true);
        insert pb;
        Product2 p = new Product2(Name = 'testProduct', IsActive = true);
        insert p;
        PriceBookEntry pbe = new PriceBookEntry();
        pbe.Product2Id = p.Id;
        pbe.Pricebook2Id = stpb.Id;
        pbe.IsActive = true;
        pbe.UnitPrice = 1000;
        insert pbe;
        Opportunity o = new Opportunity(Name = 'testOpp', Type = 'NewCustomer', 
                                        Amount = 1000, CloseDate = System.Today(), StageName = 'Prospecting');
        insert o;
        OpportunityProductAmountCalculation__c opac = new OpportunityProductAmountCalculation__c();
        opac.Name = 'testOPAC';
        opac.Min__c = 1;
        opac.Max__c = 30;
        opac.Product__c = p.Id;
        opac.Price__c = 300;
        insert opac;
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = o.Id, Product2Id = p.Id, UnitPrice = 10000, Quantity = 10, PricebookEntryId = pbe.Id);
        insert oli;
    }
    @isTest
    static void testCase(){  
    }
}