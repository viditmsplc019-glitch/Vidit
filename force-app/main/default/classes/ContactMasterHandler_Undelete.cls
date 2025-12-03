public class ContactMasterHandler_Undelete {
    public void undeleteContactRelationshipsByContact(list<Contact>lstcon){
        set<Id>ContactIds = New set<Id>();
        if(lstcon!=null&&lstcon.size()>0)
        {
            list<Contact_Relationship__c>lstconss = new list<Contact_Relationship__c>();
            lstconss = [Select Id from Contact_Relationship__c Where isDeleted=True and Contact__c In:GlobalUtility.getUniqueIds(lstcon) All ROWS];
            undelete lstconss;
            
            
        }
        
        
        
    }
}