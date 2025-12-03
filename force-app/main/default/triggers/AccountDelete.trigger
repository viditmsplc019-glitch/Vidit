trigger AccountDelete on Account (before delete) {
    
    for(Account acc:Trigger.old){
        acc.adderror('You Cannot Delete The Account Record');
    }

}