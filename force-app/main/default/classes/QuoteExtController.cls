public with sharing class QuoteExtController {
    private Id quoteId;
    public QuoteExtController(ApexPages.StandardController stdController) {
        quoteId = stdController.getId();
    }
    public PageReference onSubmit() {
        if (quoteId != null) {
           sbaa.ApprovalAPI.submit(quoteId, sbaa__Approval__c.Quotes__c);
           //sbaa.ApprovalAPI.submit(quoteId, SBQQ__Quote__c.Id);  // Only if API expects a field reference

        }
        return new PageReference('/' + quoteId);
    }
    public PageReference onRecall() {
        if (quoteId != null) {
            sbaa.ApprovalAPI.recall(quoteId, sbaa__Approval__c.Quotes__c);
        }
        return new PageReference('/' + quoteId);
    }
}