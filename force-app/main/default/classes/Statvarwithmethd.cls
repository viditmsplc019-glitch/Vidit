public class Statvarwithmethd {
    integer id ;
    string name;
    static String College ='bbdit';
    public static void me(){
        College = 'Hcst';
    }
    public Statvarwithmethd(integer r , string n){
        id = r;
        name = n;
        
    } 
    public void display(){
        System.debug(id + ' ' + name + ' ' + College);
    }
    

}