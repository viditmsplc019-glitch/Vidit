trigger Trigger_43 on Account (before insert) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            For(Account av:trigger.new){
                if(av.Active__c == 'Yes'){
                    av.Description ='Angola';
                }
            }
            
        }
    }

    }