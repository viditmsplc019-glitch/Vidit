public class TriggerAssignmentA {
    public Static Void TriggerAssn(list<Account> bb){  
        Set<Id> accids = new Set<Id>();
        for (Account acc:bb) {
            accids.add(acc.Id);
        
      }
        List<Case> closedCases = [SELECT Id, AccountId FROM Case WHERE AccountId IN :accids AND Status = 'Closed'];
        
        Map<Id, Integer> mapCnt = new Map<Id, Integer>();
        
        for (Case cas : closedCases) {
            if (mapCnt.containsKey(cas.AccountId)) {
                mapCnt.put(cas.AccountId, mapCnt.get(cas.AccountId) + 1);
            } else {
                mapCnt.put(cas.AccountId, 1);
            }
        }
        
        List<Account> lstupacc = new List<Account>();
        List<Account> lstacc = [SELECT Id, Rating FROM Account WHERE Id IN :accids];
        
        for (Account acc :lstacc ) {
            Integer count = mapCnt.containsKey(acc.Id) ?  mapCnt.get(acc.Id) : 0;
            String newRating;
            
            if (count <= 2) {
                newRating = 'Cold';
            } if(count>2) {
                newRating = 'Warm';
            }
            if(count>5) {
                newRating = 'Hot';
            }
            
            if (acc.Rating != newRating) {
                acc.Rating = newRating;
                lstupacc.add(acc);
            }
        }
        
        if (!lstupacc.isEmpty()) {
            update lstupacc;
        }
    }
}