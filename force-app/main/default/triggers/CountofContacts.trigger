trigger CountofContacts on Contact (after insert,after delete) {
    list<Contact> lstcon = new list<Contact>();
    list<Contact> lsstcon = new list<Contact>();
    Set<Id> ssid = new Set<Id>();
    list<Account> lstacc = new list<Account>();
    list<Account> lsstacc = new list<Account>();
    map<Id,integer> mapcnt = new map<id,integer>();
    if(trigger.isInsert){
        for(Contact con:trigger.new){
            ssid.add(con.accountId);
        }
        
    }
    
    
    
    if(trigger.isDelete){
        
        for(contact con:trigger.Old){
            ssid.add(con.accountid);
        }
        
    }
    lstacc = [Select id,name from account where id in:ssid];
    lsstcon = [Select id ,name,accountid from contact where accountid in:ssid];
    for(Account acc:lstacc){
        lstcon.clear();
        for(contact c : lsstcon){
            if(c.AccountId==acc.id){
                lstcon.add(c);
                mapCnt.put(c.AccountId,lstcon.size());
                
            }
            
        }
        
    }
    if(lstacc.size()>0){
        for(account a:lstacc){
            if(mapcnt.get(a.id)==null)
                a.Count_Of_Contacts__c=0;
            else
                a.Count_Of_Contacts__c = mapcnt.get(a.Id);
            lsstacc.add(a);
        }
    }
    if(lsstacc.size()>0)
        update lsstacc;
}