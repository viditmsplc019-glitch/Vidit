trigger DeleteAccountTeam on Customer__c (before delete) 
{
    List<AccountTeamMember> atm_list=new List<AccountTeamMember>();	
    AccountTeamMember atm = new AccountTeamMember();
    List<AccountShare> newShare = new List<AccountShare>();
    if(trigger.isdelete)
    {
        set<id> setAccids = new set<id>();
        Set<Id> setDelATM=new Set<Id>();
        Map<id,Set<Id>> mapAccMgrs=new Map<id,Set<Id>>();
        for(Customer__c c:Trigger.old)
        {
            setAccids.add(c.Account__c);
        }
        List<Customer__c> listPLAccMgrs=[select id,Account_Manager__c,Account__c from
                                         Customer__c where Account__c in:setAccids and id not in:trigger.oldmap.keyset()];
        if(listPLAccMgrs!=null && listPLAccMgrs.size()>0)
        {
            for(Customer__c c:listPLAccMgrs)
            {
                Set<Id> idMgrs=mapAccMgrs.get(c.Account__c);
                if(null==idMgrs)
                {
                    idMgrs=new set<Id>();
                    mapAccMgrs.put(c.Account__c,idMgrs);
                }
                idMgrs.add(c.Account_Manager__c);
            }
        }
        Map<id,List<AccountTeamMember>> mapStdAccTeam=new
            Map<id,List<AccountTeamMember>>();
        List<AccountTeamMember> listStdAccTeam=[select id,UserId,AccountId from AccountTeamMember where AccountId in:setAccids];
        if(listStdAccTeam!=null && listStdAccTeam.size()>0)
        {
            for(AccountTeamMember recAccTeam :listStdAccTeam)
            {
                List<AccountTeamMember>
                    listStdAccTeamMap=mapStdAccTeam.get(recAccTeam.AccountId);
                if(null==listStdAccTeamMap)
                {
                    listStdAccTeamMap=new List<AccountTeamMember>();
                    mapStdAccTeam.put(recAccTeam.AccountId,listStdAccTeamMap);
                }
                listStdAccTeamMap.add(recAccTeam);
            }
        }
        for(Customer__c c:Trigger.old)
        {
            List<AccountTeamMember>
                listAccTeam=mapStdAccTeam.get(c.Account__c);
            Set<Id> idMgrs=mapAccMgrs.get(c.Account__c);
            if(listAccTeam!=null && listAccTeam.size()>0 )
            {
                if(idMgrs!=null && idMgrs.size()>0 && !(idMgrs.Contains(trigger.oldmap.get(c.Id).Account_Manager__c)))
                {
                    for(AccountTeamMember recATM:listAccTeam)
                    {
                        if(recATM.UserId==trigger.oldmap.get(c.Id).Account_Manager__c)
                            setDelATM.add(recATM.Id);
                    }
                }
                else if(idMgrs==null)
                {
                    for(AccountTeamMember recATM:listAccTeam)
                        setDelATM.add(recATM.Id);
                }
            }
        }
        List<AccountTeamMember> listDelATM=[select id from AccountTeamMember  where id in:setDelATM];
        
        if(listDelATM!=null && listDelATM.size()>0 )
            delete listDelATM;
    }
}