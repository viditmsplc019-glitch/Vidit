public with sharing class UserController {
    
    @AuraEnabled(cacheable=true)
    public static List<User> getUsers() {
        return [SELECT Id, Name,Email,IsActive, Username FROM User LIMIT 50];
    }

    @AuraEnabled
    public static User createUser(User userData) {
        insert userData;
        return userData;
    }

    @AuraEnabled
    public static User updateUser(User userData) {
        update userData;
        return userData;
    }
}