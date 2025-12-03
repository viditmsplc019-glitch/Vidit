trigger Trigstart4 on Account (before insert, before update) {
List<Account> dup = [Select id, Name from Account];            
    for(Account a:Trigger.New){
        for(Account a1:dup){
            if(a.Name==a1.Name){
            a.Name.addError('You Cannot Create the Duplicate Account');
            }


}
    }
}