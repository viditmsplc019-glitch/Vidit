trigger triggerAssignment6 on Contact (before insert, before update) {
    list<Contact> lstCot = trigger.new;
    triggerAssignmentF.Triggassign(lstCot);
 }