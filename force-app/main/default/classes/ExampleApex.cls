public with sharing class ExampleApex {

    @AuraEnabled(cacheable=false)
    public static String methodA(Boolean failA) {
        if (failA == true) {
            return null; // simulate failure
        }
        return 'A-OK';
    }

    @AuraEnabled(cacheable=false)
    public static String methodB(Boolean failB) {
        if (failB == true) {
            return null;
        }
        return 'B-OK';
    }

    @AuraEnabled(cacheable=false)
    public static String methodC(Boolean failC) {
        if (failC == true) {
            return null;
        }
        return 'C-OK';
    }
}