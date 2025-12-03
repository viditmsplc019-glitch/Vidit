trigger triggerAssingnment8 on Opportunity (before insert,before update) {
    
    
    
    For(Opportunity opp:Trigger.new){
        if(opp.Amount!=null && opp.Amount>100000){
            opp.Description = 'Hot Opportunity';
        }
        break;
    }
    
    
}