public class ContactMasterHandler {
    public static void createConrealtnbycon(list<Contact>listContact){
        list<Contact_Relationship__c> conlist = new list<Contact_Relationship__c>();
        for(Contact newconlist:listContact){
            if(newconlist.Contact_Relationship__c==true){
                Contact_Relationship__c cr = new Contact_Relationship__c();
                cr.Name= newconlist.FirstName+newconlist.LastName;
                cr.Contact__c=newconlist.Id;
                Conlist.add(cr);
                System.debug(cr.Name);
                System.debug(newconlist.Name);
            }
        }
        if(Conlist.size()>0)
            insert Conlist;
        
    }
    
    
}