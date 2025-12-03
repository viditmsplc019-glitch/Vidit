trigger triggerAssignment5 On Contact (before insert) {
    List<Contact> lstcont = Trigger.new;
    TriggerAssignnmentE.Trigassigw(lstcont);
    
}