public class Overloadconts {
    Integer id;
    String name;
    Integer Age;
    public Overloadconts(Integer i ,String n){
        id = i;
        name=n;
        
    }
    public Overloadconts(Integer i , String n , integer j){
        id = i;
        name = n;
        age = j;
        
    }
    public void output(){
        System.debug( id + ' ' + name + ' ' + Age);
    }

}