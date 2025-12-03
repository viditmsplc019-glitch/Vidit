trigger DeleteCRonContactDeletion on Contact (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        Set<id> contactIds = Trigger.oldmap.keySet();
        List<Contact_Relationship__c> relations = [Select Id From Contact_Relationship__c Where Contact__c IN:contactids];
            if(!relations.isEmpty()){
                delete relations;
            }
    }
    
}