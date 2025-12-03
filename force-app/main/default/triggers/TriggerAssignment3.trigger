trigger TriggerAssignment3 on Contact (before insert, before update) {
    list<Contact> ccd = Trigger.new;
    TriggerAssignmentC.trigassne(ccd);
    
    
}