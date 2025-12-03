trigger triggerAssingnment9 on Account (before insert,before update) {
    For(Account acc:Trigger.new){
        if(acc.Copy_Billing_To_Shipping__c == True){
            acc.ShippingCountry = acc.BillingCountry;
            acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingPostalCode = acc.BillingPostalCode;
            acc.ShippingState = acc.BillingState ;
            
        }
    }
    
    
}