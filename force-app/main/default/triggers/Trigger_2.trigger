trigger Trigger_2 on Account (before insert) {
    if(trigger.isBefore){ 
        if(trigger.isInsert){
            
                for(Account acaa:Trigger.new){
                if(acaa.Industry == 'Banking'){
                    acaa.Rating = 'Warm';
                    
                    
                    
                }
            }
            
        }
    }
    
    
}