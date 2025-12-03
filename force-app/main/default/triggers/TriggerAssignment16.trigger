trigger TriggerAssignment16 on Contact (after insert, after update, after delete) {
    Set<Id> accountIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if (Trigger.isUpdate || Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if (accountIds.isEmpty()) return;

    Map<Id, Account> accMap = new Map<Id, Account>(
        [SELECT Id, Description FROM Account WHERE Id IN :accountIds]
    );

    List<Contact> relatedContacts = [ SELECT Id, Name, CreatedDate, AccountId FROM Contact WHERE AccountId IN :accountIds];

    Map<Id, List<Contact>> accToContacts = new Map<Id, List<Contact>>();
    for (Contact con : relatedContacts) {
        if (!accToContacts.containsKey(con.AccountId)) {
            accToContacts.put(con.AccountId, new List<Contact>());
        }
        accToContacts.get(con.AccountId).add(con);
    }

    List<Account> accToUpdate = new List<Account>();

    for (Id accId : accMap.keySet()) {
        Account acc = accMap.get(accId);
        List<Contact> cons = accToContacts.get(accId);
        if (cons != null && !cons.isEmpty()) {
            List<String> descParts = new List<String>();
            for (Contact con : cons) {
                descParts.add(con.Name + ' - ' + String.valueOf(con.CreatedDate.date()));
            }
            acc.Description = String.join(descParts, ', ');
        } else {
            acc.Description = null;
        }
        accToUpdate.add(acc);
    }

    if (!accToUpdate.isEmpty()) {
        update accToUpdate;
    }
}