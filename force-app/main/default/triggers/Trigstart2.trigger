trigger Trigstart2 on Top_X_Designation__c (After insert, After update,After Delete) {
    Map<Id,Id> mapDocAttchTrue = new Map<Id,Id>();
    Map<Id,Id> mapDocAttchFalse = new Map<Id,Id>();
    Map<Id,Id> mapDelete = new Map<Id,Id>();
    Set<Id> setOppId= new Set<Id>();
    Set<Id> setOppIdDelete= new Set<Id>();
   
    List<Opportunity> listOppUpdate = New List<Opportunity>();
   
    if(Trigger.isInsert || Trigger.isUpdate){
        for(Top_X_Designation__c  ada : Trigger.new){
            if(ada.Document_Attacthed__c && ada.Item_Type__c =='Contract Flow Down/Handoff') {
                mapDocAttchTrue.put(ada.Opportunity__c,ada.Id);
                setOppId.add(ada.Opportunity__c);
            }else{
                mapDocAttchFalse.put(ada.Opportunity__c,ada.Id);
                setOppId.add(ada.Opportunity__c);
            }
           
           
        }
    }
    If(Trigger.isDelete){
        for(Top_X_Designation__c  ada : Trigger.old){
        setOppIdDelete.add(ada.Opportunity__c);
        setOppId.add(ada.Opportunity__c);
        }
    }
    List<Opportunity> listOpp = [Select id,Handoff_Attached__c from Opportunity Where Id IN :setOppId];
    System.debug('>>>listOpp'+listOpp);
    if(listOpp != null && !listOpp.isEmpty()){
        for(Opportunity opp : listOpp){
            if(mapDocAttchTrue.containskey(opp.id)){
                opp.Handoff_Attached__c = 'Yes';
            }
            if(mapDocAttchFalse.containskey(opp.id)){
                opp.Handoff_Attached__c = 'No';
            }
            if(setOppIdDelete.contains(opp.id)){
                opp.Handoff_Attached__c = '';
            }
            listOppUpdate.add(opp);  
        }
    }
    if(!listOppUpdate.isEmpty()){
        update listOppUpdate;
    }
   
}