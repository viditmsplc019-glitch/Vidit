trigger OppTeam on Opportunity (after insert) {
    list<OpportunityShare> sharestoCreate = new List<OpportunityShare>();
    list<OpportunityTeamMember> oppteam = new List<OpportunityTeamMember>();
    
    OpportunityShare oppshare = new OpportunityShare();
    oppshare.OpportunityAccessLevel = 'Edit';
    oppshare.OpportunityId = trigger.new[0].Id;
    oppshare.UserOrGroupId = trigger.new[0].createdbyid;
    sharestoCreate.add(oppshare);
    OpportunityTeamMember oppTeamMember = new OpportunityTeamMember();
    oppTeamMember.OpportunityId = trigger.new[0].Id;
    oppTeamMember.UserId = trigger.new[0].OwnerId;
    oppTeamMember.TeamMemberRole = 'Account Manager';
    oppteam.add(oppTeamMember);
    if(oppteam!=null&&oppteam.size()>0){
         insert oppteam;
    }
    if(sharesToCreate!=null&& sharesToCreate.size()>0){
        list<Database.SaveResult> sr = Database.insert(sharesToCreate,false);
    }
    
}