public class Accountcreation {
    public Account createAccount(String name){
        Account a = new Account();
        
        a.Name = name;
      //  a.Email__c = email;
        insert a; 
        return a;
       
    }

}