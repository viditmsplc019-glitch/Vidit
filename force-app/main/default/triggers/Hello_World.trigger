trigger Hello_World on Account (before insert, before update) {
    List<Account> accs = Trigger.new;
    MyHelloWorld my = new MyHelloWorld();
    my.addHelloWorld(accs);
    

}