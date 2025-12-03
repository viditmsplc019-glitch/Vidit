trigger ContactsCreation on Account (after insert) {
    List<Contact> Lstcon = new List<Contact>();
    Map<Id,Decimal> mapacc = new Map<Id ,Decimal>();
    for(Account acc:Trigger.new){
        mapacc.put(acc.Id,acc.Number_of_Locations__c);
    }
    if(mapacc.size()>0 && mapacc!=null){
        for(id acid:mapacc.keyset()){
            for(Integer i=0;i<mapacc.get(acid);i++){
                contact newCon = new contact();
                newCon.accountid = acid;
                newCon.LastName = 'contact'+i;
                Lstcon.add(newCon);
                
          
            
        }
    }
        if(Lstcon.size()>0 && Lstcon!=null)
            insert Lstcon;
}
}