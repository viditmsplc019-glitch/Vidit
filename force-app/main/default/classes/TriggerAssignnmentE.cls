public class TriggerAssignnmentE {
    public static void Trigassigw(list<Contact>lstcont){
        
        List<Account> newAccounts = new List<Account>();
        List<Integer> noofCon = new List<Integer>();
        
        
        for (Integer i = 0; i < lstcont.size(); i++) {
            Contact contt = lstcont[i];
            if (contt.AccountId == null) {
                Account acc = new Account();
                acc.Name = contt.LastName + ' Account'; 
                newAccounts.add(acc);
                noofCon.add(i); 
            }
        }
        
        
        if (!newAccounts.isEmpty()) {
            insert newAccounts;
            
            
            for (Integer j = 0; j < noofCon.size(); j++) {
                Integer index = noofCon[j];
                lstcont[index].AccountId = newAccounts[j].Id;
            }
        }
    }
    
}