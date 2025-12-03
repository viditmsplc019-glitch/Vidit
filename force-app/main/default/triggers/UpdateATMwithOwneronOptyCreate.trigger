trigger UpdateATMwithOwneronOptyCreate on Opportunity (after insert, after update) {
    list<AccountShare> lstshare = new list<AccountShare>();
    list<AccountTeamMember> Lstatm = new list<AccountTeamMember>();
    for(Opportunity opp:Trigger.new){
        if(opp.Probability==20){
            AccountTeamMember atm = new AccountTeamMember();
            atm.AccountId = opp.accountid;
            atm.TeamMemberRole = 'Account Manger';
            atm.UserId = opp.OwnerId;
            AccountShare share = new AccountShare();
            share.AccountAccessLevel='Read/Write';
            share.opportunityAccesslevel = 'Read Only';
            share.CaseAccessLevel ='Read Only';
            lstatm.add(atm);
            lstshare.add(share);
        }
    }
    
    if(lstatm!=null)
        insert lstatm;
    if(lstshare!=null&&lstshare.size()>0)
        list<Database.saveresult> sr=Database.insert(lstshare,false);
    
    
    
}