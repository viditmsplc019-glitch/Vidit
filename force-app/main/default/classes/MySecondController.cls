public class MySecondController 
{
Public Opportunity opp;
public MySecondController()
{
opp= [select id,Name,DeliveryInstallationStatus__c,TrackingNumber__c,CloseDate from Opportunity where id=:ApexPages.currentPage().getParameters().get('Id')];
}
public Opportunity getOpportunity () 
{
return opp;
}
public PageReference SaveMethod() 
{
update opp;
return null;
}
}