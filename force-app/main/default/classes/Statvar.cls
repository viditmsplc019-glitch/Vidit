public class Statvar {
    integer id;
    string name;
    static string college = 'itc';
    public Statvar( integer r , string v){
        id = r ;
        name = v;
       
        
    }
    public void Output(){
        System.debug(id + ' ' + name + ' ' + college);
    }

}