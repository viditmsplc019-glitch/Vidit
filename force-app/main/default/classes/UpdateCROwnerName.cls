public class UpdateCROwnerName {
    public static Void UpdateRelationshipNameByOwner(list<Contact_Relationship__c> Conrel){
        Map<id,id> mapidown = new Map<id,id>();
        Map<id,string> Mapidnam = new map<id,string>();
        set<id> Idset = new set<id>();
        for(Contact_Relationship__c listrecs:Conrel)
        {
            idset.add(listrecs.Ownerid);
            
        }
        list<user> u = [Select id, Name from user where id in:Idset];
        for(user lstuser:u){
            mapidnam.put(lstuser.Id,lstuser.Name);
        }
        if(u!=null&&u.size()>0){
            for(Contact_Relationship__c listrecs:conrel){
                if(listrecs.Ownerid!=null){
                    listrecs.Name = mapidnam.get(listrecs.OwnerId);
                }
            }
        }
    }    
    
}