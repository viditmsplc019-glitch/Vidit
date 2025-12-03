trigger triggerAssignment7 on Lead (before insert,before update) {
    list<lead> ldlst = trigger.new;
    TriggerAssignmentG.Triggasssin(ldlst);
}