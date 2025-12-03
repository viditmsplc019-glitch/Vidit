public with sharing class MultipleContactRelationships 
{
public MultipleContactRelationships(ApexPages.StandardController controller) 
{
}
public List<Contact> ContactList{get;set;}
Public List<Contact>getConres()
{
Contact c = new Contact();

ContactList=[select id, Name,Title,Email,Phone from Contact where Accountid=:ApexPages.currentPage().getParameters().get('id') and Contact_Relationship__c=true ];
system.debug('********'+ ContactList);
return ContactList;

	}
}