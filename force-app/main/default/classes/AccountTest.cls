@isTest
public class AccountTest {
    @TestSetup
    static Void TriggerAssn1(){
        Account Acc = new Account();
     
        
        Case Cas = new Case();
        Cas.AccountId = Acc.Id;
        Cas.Status = 'Closed';
        Acc.Rating = 'Hot';
        
    }

}