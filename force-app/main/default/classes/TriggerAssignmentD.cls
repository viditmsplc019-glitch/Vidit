public class TriggerAssignmentD {
    public static void Trigassner(list<Opportunity> oopps){
         Set<Id> accids = new Set<Id>();

    
    for (Opportunity opp : oopps) {
        if (opp.AccountId != null) {
            accids.add(opp.AccountId);
        }
    }

    
    List<Account> acclst = [SELECT Id, Is_Opp_Eligible_for_Close__c FROM Account WHERE Id IN :accids];

    
    for (Opportunity opp : oopps) {
        if (opp.AccountId != null) {
            for (Account acc : acclst) {
                if (acc.Id == opp.AccountId && acc.Is_Opp_Eligible_for_Close__c == true) {
                    if (opp.Probability >= 70) {
                        opp.StageName = 'Closed Won'; 
                    }
                    break;
                }
            }
        }
    }
        
    }

}