trigger UpdateAccountTeam on Customer__c (before update)
{
    List<AccountTeamMember> atm_list=new List<AccountTeamMember>();
    AccountTeamMember atm = new AccountTeamMember();
    List<AccountShare> newShare = new List<AccountShare>();
    if(trigger.isupdate)
    {
        if(trigger.isbefore)
        {
            Set<Id> setAccIds1=new Set<Id>();
            Set<Id> setDelATM=new Set<Id>();
            Map<id,Set<Id>> Mpmgrs=new Map<id,Set<Id>>();
            for(Customer__c c:Trigger.new)
            {
                if(trigger.oldmap.get(c.Id).Account_Manager__c!=c.Account_Manager__c &&c.Account_Manager__c!=null )
                {
                    setAccIds1.add(c.Account__c);
                }
            }
            List<Customer__c> listPLAccMgrs=[select id,Account_Manager__c,Account__c from Customer__c where Account__c in:setAccIds1 and id not in:trigger.newmap.keyset()];
            
            if(listPLAccMgrs!=null && listPLAccMgrs.size()>0)
            {
                for(Customer__c c:listPLAccMgrs)
                {
                    Set<Id> fdm=Mpmgrs.get(c.Account__c);
                    if(null==fdm)
                    {
                        fdm=new set<Id>();
                        Mpmgrs.put(c.Account__c,fdm);
                    }
                    fdm.add(c.Account_Manager__c);
                }
            }
            Map<id,List<AccountTeamMember>> MpstTm = new Map<id,List<AccountTeamMember>>();
            
            List<AccountTeamMember> listStdAccTeam=[select id,UserId,AccountId from AccountTeamMember where AccountId in:setAccIds1 ];
            
            if(listStdAccTeam!=null && listStdAccTeam.size()>0)
            {
                for(AccountTeamMember Rect :listStdAccTeam)
                {
                    List<AccountTeamMember>
                        listStdAccTeamMap=MpstTm.get(Rect.AccountId);
                    
                    if(null==listStdAccTeamMap)
                    {
                        listStdAccTeamMap=new List<AccountTeamMember>();
                        MpstTm.put(Rect.AccountId,listStdAccTeamMap);
                    }
                    listStdAccTeamMap.add(Rect);
                }
            }
            system.debug('***********'+Mpmgrs);
            for(Customer__c c:Trigger.new)
            {
                if(trigger.oldmap.get(c.Id).Account_Manager__c!=c.Account_Manager__c &&c.Account_Manager__c!=null )
                {
                    List<AccountTeamMember>
                        listAccTeam=MpstTm.get(c.Account__c);
                    Set<Id> fdm = Mpmgrs.get(c.Account__c);
                    if(listAccTeam!=null && listAccTeam.size()>0 )
                    {
                        if(fdm!=null && fdm.size()>0 && !(fdm.Contains(trigger.oldmap.get(c.Id).Account_Manager__c)))
                        {
                            for(AccountTeamMember recTA:listAccTeam)
                            {
                                if(recTA.UserId==trigger.oldmap.get(c.Id).Account_Manager__c)
                                    setDelATM.add(recTA.Id);
                            }
                        }
                        else if(fdm==null)
                        {
                            for(AccountTeamMember recTA:listAccTeam)
                                setDelATM.add(recTA.Id);
                        }
                    }
                    
                    atm = new AccountTeamMember(accountid=c.Account__c,teamMemberRole='Account Manager',UserId=c.Account_Manager__c);
                    AccountShare shares = new AccountShare();
                    shares.AccountId=c.Account__c;
                    shares.UserOrGroupId = c.Account_Manager__c;
                    shares.AccountAccessLevel='Edit';
                    shares.OpportunityAccessLevel = 'None';
                    newShare.add(shares);
                    atm_list.add(atm);
                }
            }
            List<AccountTeamMember> listDelATM=[select id from AccountTeamMember where id in:setDelATM];
            if(listDelATM!=null && listDelATM.size()>0 )
                delete listDelATM;
            if(atm_list!=null)
                insert atm_list;
            if(newShare!=null && newShare.size()>0)
                List<Database.saveresult> sr=Database.insert(newShare,false);
        }
    }
}