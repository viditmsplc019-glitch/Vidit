public class FetchAccountNameFromPhone {
    public Set<String> FetchAccName(String p){
        Set<String> s1 = new Set<String>();
        List<Account> AccList = [Select id , Name From Account Where phone=:p];
        For(Account AccObj:AccList){
            String s = AccObj.Name;
            s1.add(s);
            
            
        }
        System.debug(s1);
        return s1;
        
    }

}