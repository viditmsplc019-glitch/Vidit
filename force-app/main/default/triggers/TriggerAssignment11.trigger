trigger TriggerAssignment11 on Case (after insert) {
    List<Id> accIds = new List<Id>();
    for (Case cce : Trigger.new) {
        if (cce.AccountId != null && !accIds.contains(cce.AccountId)) {
            accIds.add(cce.AccountId);
        }
    }
    List<Case> latcase = [SELECT Id, CaseNumber, AccountId FROM Case WHERE AccountId IN :accIds ORDER BY CreatedDate DESC];
    
    List<Account> updtAcc= new List<Account>();
    
    List<Id> AccIdproc = new List<Id>();
    
    for (Case cce : latcase) {
        if (!AccIdproc.contains(cce.AccountId)) {
            Account Accd = new Account(Id = cce.AccountId,Latest_Case_Number__c = cce.CaseNumber);
            updtAcc.add(Accd);
            AccIdproc.add(cce.AccountId);
        }
    }
    
    if (!updtAcc.isEmpty()) {
        update updtAcc;
    }
}