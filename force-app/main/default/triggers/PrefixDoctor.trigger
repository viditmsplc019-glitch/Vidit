trigger PrefixDoctor on Lead (before insert) {
    List<Lead> accs = Trigger.new;
    for(Lead l:accs){
        l.firstname = 'DR.'+  l.firstname;
    }
}