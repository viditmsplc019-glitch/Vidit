public class Datatypvar {
    public void xyz(){
        integer i = 10;
        System.debug('i value :'+ i);
        Long l = 2345678;
        System.debug('l value :'+ l);
        String s = 'Vidit';
        System.debug('s value :'+ s);
        List<Account> lstacc = [SELECT ID, Name From Account Limit 1 ];
        System.debug('lstacc value :' + lstacc );
        Decimal d = 2.4;
        System.debug('d value :'+ d);
        Double c = 2.444444;
        System.debug('c value :' + c);
        
    }

}