public class MyCustomController
{
Public Account acc;
public MyCustomController()
{
acc = [select id,Name,Phone,Industry,Website,Active__c,Rating,BillingCity,Description,Fax,ShippingCity,AnnualRevenue,BillingCountry,ShippingCountry from Account where id=:ApexPages.currentPage().getParameters().get('Id')];
}
public Account getAccount() 
{
return acc;
}
public PageReference saveMethod() 
{
update acc;
PageReference pageRef = new ApexPages.StandardController(acc).view();
return pageRef;
}
}