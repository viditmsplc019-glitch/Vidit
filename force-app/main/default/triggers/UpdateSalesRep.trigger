trigger UpdateSalesRep on Account (before insert,before update) {
   /* set<Id>setAccOwner=new set<Id>();
    for(Account Acc:Trigger.New)
    {
        setAccOwner.add(Acc.OwnerId);
    }
    Map<id,User> User_map = new Map<id,User>([Select Name from User Where Id IN: setAccOwner ]);
    for(Account Acc:Trigger.new){
        User usr = User_map.get(Acc.OwnerId);
        Acc.Sales_Rep__c=usr.Name;
    }*/
        
    

}