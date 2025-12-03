public with sharing class CustomObjExtController {
    private Id quoteId;
    public CustomObjExtController(ApexPages.StandardController stdController) {
        quoteId = stdController.getId();
    }
    public PageReference onSubmit() {
        if (quoteId != null) {
            SBAA.ApprovalAPI.submit(quoteId, SBAA__Approval__c.CustomObj__c);
        }
        return new PageReference('/' + quoteId);
    }
    public PageReference onRecall() {
        if (quoteId != null) {
            SBAA.ApprovalAPI.recall(quoteId, SBAA__Approval__c.CustomObj__c);
        }
        return new PageReference('/' + quoteId);
    }
}