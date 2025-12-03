public with sharing class StudentController {
    
    @AuraEnabled(cacheable=true)
    public static List<School__c> getSchools() {
        return [SELECT Id, Name FROM School__c];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Class__c> getClasses(Id schoolId) {
        return [SELECT Id, Name FROM Class__c WHERE School__c = :schoolId];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudents(Id classId) {
        return [
            SELECT Id, Name, Age__c, Email__c, Class__c, Class__r.Name 
            FROM Student__c 
            WHERE Class__c = :classId
        ];
    }
    
    @AuraEnabled
    public static void saveStudentRecord(Student__c student) {
        upsert student;
        updateClassStudentCount(student.Class__c);
        
        if (student.Email__c != null) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { student.Email__c });
            mail.setSubject('Welcome to Class');
            mail.setPlainTextBody('Hello ' + student.Name + ', You have been added successfully.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
    
    @AuraEnabled
    public static void deleteStudents(List<Id> studentIds) {
        List<Student__c> studs = [SELECT Id, Class__c FROM Student__c WHERE Id IN :studentIds];
        delete studs;
        
        Set<Id> classIds = new Set<Id>();
        for (Student__c s : studs) {
            classIds.add(s.Class__c);
        }
        for (Id cId : classIds) {
            updateClassStudentCount(cId);
        }
    }
    
    private static void updateClassStudentCount(Id classId) {
        Integer countStudents = [SELECT COUNT() FROM Student__c WHERE Class__c = :classId];
        Class__c c = new Class__c(Id = classId, NumberOfStudent__c = countStudents);
        update c;
    }
}