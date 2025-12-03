trigger TriggerAssignment15 on Case (before insert) {
    Set<String> suppliedEmails = new Set<String>();

    
    for (Case cce : Trigger.new) {
        if (cce.SuppliedEmail != null && cce.ContactId == null) {
            suppliedEmails.add(cce.SuppliedEmail.trim().toLowerCase());
        }
    }

    if (suppliedEmails.isEmpty()) return;

    
    List<Contact> matchingContacts = [SELECT Id, Email FROM Contact WHERE Email IN :suppliedEmails];

    
    Map<String, Contact> emlconmp = new Map<String, Contact>();
    for (Contact con : matchingContacts) {
        emlconmp.put(con.Email.toLowerCase(), con);
    }

    
    List<Contact> contactsToCreate = new List<Contact>();
    Map<Id, Contact> caseToNewContact = new Map<Id, Contact>();

    for (Case cce : Trigger.new) {
        if (cce.SuppliedEmail != null && cce.ContactId == null) {
            String email = cce.SuppliedEmail.trim().toLowerCase();

            if (emlconmp.containsKey(email)) {
               
                cce.ContactId = emlconmp.get(email).Id;
            } else {
             
                Contact newCon = new Contact(
                    LastName = 'Auto-Created from Case',
                    Email = email
                );
                contactsToCreate.add(newCon);
                caseToNewContact.put(cce.Id, newCon);
            }
        }
    }

   
    if (!contactsToCreate.isEmpty()) {
        insert contactsToCreate;

        
        Integer i = 0;
        for (Case cce : Trigger.new) {
            if (caseToNewContact.containsKey(cce.Id)) {
                cce.ContactId = contactsToCreate[i].Id;
                i++;
            }
        }
    }
}