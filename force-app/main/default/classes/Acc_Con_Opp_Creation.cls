// This is a test class
public class Acc_Con_Opp_Creation {
    public Account createAccount(String n){
        Account a = new Account();
        a.Name = n;
        insert a;
        Contact b = new Contact();
        b.LastName = 'Gaurav Reddy';
        b.AccountId = a.Id;
        insert b;
        Opportunity c = new Opportunity();
        c.Name = 'Kundan opportunity';
        Date d = Date.newinstance(2025,8,5);
        c.CloseDate = d;
        c.StageName = 'Closed Won';
        c.AccountId = a.Id;
        insert c;
        return a;
        
            
    }

}

// This is a test class