trigger TriggerAssignment10 on Position__c (before insert,before update) {
    for(Position__c pos:Trigger.new){
        if(pos.Open_date__c ==null && pos.Min_Pay__c==null && pos.Max_Pay__c==null){
            pos.Open_date__c = System.TODAY();
            pos.Min_Pay__c = 10000;
            pos.Max_Pay__c = 15000;
            
        }
    }
    

}