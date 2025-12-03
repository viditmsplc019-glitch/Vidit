public class MyHelloWorld {
    public void addHelloWorld(List<Account> accs){
        for(Account a : accs){
            if(a.Hello__c != 'World'){
                a.Hello__c  = 'World';
            }       
        }
        
    }
    
    
}