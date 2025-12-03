global class BAtchclass implements Database.Batchable<sObject> 
    {
        
        //start Method
        
        global DataBase.QueryLocator start(DataBase.BatchableContext BC)
        {
            String query ='Select Id,Name from Account';
            	
            return DataBase.getQueryLocator(query);
        }
        //execute Method
        
        global void execute(Database.BatchableContext Bc, list<Account> scope)
        {
            for(Account a:scope)
            {
                a.Name=a.Name+'Update';
            }
            update scope;
        }
        
        //finish Method
        
        global void finish (Database.BatchableContext BC)
        {
            
        }
        
    }