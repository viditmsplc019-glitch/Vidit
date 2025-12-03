public with sharing class StudentController1 {
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getActiveStudents(Integer limitSize) {
        if (limitSize == null || limitSize < 0) {
            limitSize = 0;
        }
        if (limitSize == 0) {
            return new List<Student__c>();
        }
        return [
            SELECT Id, Name, Course__c, College__c, Active__c
            FROM Student__c
            WHERE Active__c = TRUE
            ORDER BY Name
            LIMIT :limitSize
        ];
    }
}