/*public virtual class overide1 {
    public virtual void run(){
        System.debug('what is your Name ?');
    }
   

  }

public class overid2 extends overide1{
    public override void run(){
    System.debug('My name is Vidit');
        
    }
    
    
}*/


public virtual class overide1 {
    public virtual void run() {
        System.debug('what is your Name ?');
    }
    public class overide2 extends overide1 {
    public override void run() {
        System.debug('My name is Vidit');
    }
}
}