trigger TriggerAssnContact on Contact (before insert,before Update ,before delete,After insert , after Update , after delete, after Undelete) {
    
    if(Trigger.IsBefore){
        if(trigger.IsInsert || trigger.IsUpdate){
            ContactHandler.Conthandass3(trigger.new);
        
        }
        
        
        
          if(Trigger.IsBefore){
        if(trigger.IsInsert || trigger.IsUpdate){
           
            ContactHandler.Conthandass6(trigger.new);
        }
        if(trigger.isInsert){
            ContactHandler.Conthandass5(trigger.new);
            
        }
        
        
    }
    
    
    
    if(trigger.IsAfter){
        
        
        
        if (Trigger.isInsert) {
            ContactHandler.handleAfterInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            ContactHandler.handleAfterUpdate(Trigger.new, Trigger.old);
        }
        if (Trigger.isDelete) {
            ContactHandler.handleAfterDelete(Trigger.old);
        }
        
        
    }
    
    
    
    
    if(Trigger.IsAfter){
        list<Contact>lstcon=Trigger.new;
        list<Contact>lstcons=Trigger.old;
        if (Trigger.isInsert || Trigger.isUpdate){
            ContactHandler.handleAfter(Trigger.new,trigger.old);
        }
        
        
    }
    
    
    if(Trigger.IsAfter && Trigger.IsInsert){
        ContactHandler.AfterInsertHand19(trigger.new);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
}