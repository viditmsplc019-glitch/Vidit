trigger DiscountTrigger_Books on Book__c (before insert,before Update) {
    list<Book__c> book = trigger.new;
    DiscountTrigger_Books_Class.applyDiscount(book);

}