trigger UpdateOppo on Account (After insert) {
    if(Trigger.IsAfter && Trigger.IsInsert){
         List<Opportunity> cc = new List<Opportunity>();
        For(Account Acc:Trigger.new){
            Opportunity ac = new Opportunity();
            ac.AccountId = Acc.Id;
            ac.CloseDate = Date.Today();
            ac.StageName = 'Closed Won';
            ac.Amount = 1000;
            
            
            
           
            
        }
        If(cc!=null){
            insert cc;
        }
        
    }

}