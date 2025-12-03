public class BatchOpportunityRecoredCount implements Database.Batchable<sObject>,Database.stateful
{
public integer recoredCount=0;

public Database.QueryLocator start(DataBase.BatchableContext BC)
{
    return Database.getQueryLocator([Select id,Name, leadSource from Opportunity]);
}


public void execute(Database.BatchableContext BC, list<Opportunity> opps)
{
    for(Opportunity op :opps )
    {
        if(op.leadSource =='web')
        recoredCount =recoredCount + 1;
    }
}

public void finish(Database.BatchableContext  BC)
{
    System.debug('Recored Count '+recoredCount);
}
}