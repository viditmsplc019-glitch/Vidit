trigger InsertAccountTeam on Customer__c (after insert) {
    list<AccountTeamMember> atmlst = new list<AccountTeamMember>();
    AccountTeamMember atm = new AccountTeamMember();
    list<AccountShare> newshar = new list<AccountShare>();
    if(trigger.isInsert)
    {
        for(Customer__c c:Trigger.new){
            if(c.Account_Manager__c!=null)
            {
                atm = new AccountTeamMember();
                atm.accountid=c.Account__c;
                atm.teamMemberRole='Account Manager';
                atm.UserId=c.Account_Manager__c;
                AccountShare shares = new AccountShare();
                shares.AccountId=c.Account__c;
                shares.UserOrGroupId = c.Account_Manager__c;
                shares.AccountAccessLevel='Read/Write';
                shares.OpportunityAccessLevel = 'Read Only';
                shares.CaseAccessLevel='Read Only';
                newShar.add(shares);
                atmlst.add(atm);
            }
        }
        if(atmlst!=null)
            insert atmlst;
        
        if(newShar!=null && newShar.size()>0)
            List<Database.saveresult> sr=Database.insert(newShar,false);
        
    }
    
}