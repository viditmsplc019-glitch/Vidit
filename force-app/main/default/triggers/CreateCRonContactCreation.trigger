trigger CreateCRonContactCreation on Contact (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        List<Contact> Listcon = new List<Contact>(trigger.new);
        ContactMasterhandler.createConrealtnbycon(ListCon);
    }

}