trigger UnDeleteCRonContactUnDeletion on Contact (After Undelete) {
    if(trigger.isAfter && trigger.isUndelete){
        ContactMasterHandler_Undelete Conlns = New ContactMasterHandler_Undelete();
        Conlns.UndeleteContactRelationshipsByContact(Trigger.New);
    }

}