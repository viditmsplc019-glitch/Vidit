public class DiscountTrigger_Books_Class {
    public static void applyDiscount(list<Book__c> Book ){
        for(Book__c  bk:Book){
            bk.Price__c*=0.9;
        }
    }
}