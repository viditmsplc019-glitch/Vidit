trigger UpdateCPActivenOnOppty on Customer_Project__c (after insert) {
    List<Opportunity> ops = new List<Opportunity>();
    for(Customer_Project__c cp:Trigger.New){
        if(cp.Status__c=='Active')
        {
            Opportunity op = new Opportunity(id=cp.Opportunity__c);
            op.Active_Customer_Project__c=True;
            ops.add(op);
        }
    }
}