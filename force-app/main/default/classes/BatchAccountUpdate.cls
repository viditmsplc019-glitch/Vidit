global class BatchAccountUpdate implements Database.Batchable<sObject> 
{



global DataBase.QueryLocator start(DataBase.BatchableContext BC)
{
String query ='Select Id,Name from Account';
return DataBase.getQueryLocator(query);


}


global void execute(Database.BatchableContext Bc, list<Account> scope)
{
for(Account a:scope)
{
    a.Name=a.Name+'Update';
}
update scope;


}



global void finish (Database.BatchableContext BC)
{

}
}