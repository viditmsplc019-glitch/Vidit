trigger TriggerAssignment4 on Opportunity (before insert, before update) {
    list<Opportunity> oopps = trigger.new;
    TriggerAssignmentD.Trigassner(oopps);
    
    
}