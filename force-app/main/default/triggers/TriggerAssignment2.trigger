trigger TriggerAssignment2 on Case (after insert, after update) {
    list<case> cc = Trigger.new;
    TriggerAssignmentB.Trigassn(cc);
    
}