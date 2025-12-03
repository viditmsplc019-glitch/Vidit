public class Maptst {
    public static void xyz(){
        Map<integer , string> m1 = new  Map<integer,string>{1 => 'one' , 2 => 'two'};
        m1.put(3 ,'Three');
        Map<integer , string> m2 = new  Map<integer,string>(m1);
        System.debug(m2);
        List<Account> l1 = [Select Id , Name From Account Limit 3];
        Map<Id , sobject > m3 = new  Map<Id,sobject>(l1);
        System.debug(m3);
        Map<integer , string> m4 = m2.clone();
        System.debug(m4);
        System.debug(m2.containskey(3));
        Boolean b = m2.equals(m1);
        System.debug(b);
        System.debug(m2.get(3));
        integer i = m2.size();
        System.debug(i);
        System.debug(m2.values());
        
        
        
        
    }

}