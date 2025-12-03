public class Accountcreate {
    public List<Account> CreateAccount(String name, String phone , Integer n ){
       List<Account> A = new List<Account>();
        For(Integer i =0 ; i<n ; i++){
            Account acc = new Account();
            acc.Name = name + i;
            acc.Phone = phone;
            A.add(acc);
            
        }
        return A;
    }

}