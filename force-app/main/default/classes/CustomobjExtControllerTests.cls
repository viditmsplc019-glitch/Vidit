@isTest
private class CustomobjExtControllerTests {
    
    @isTest
    static void testSubmit() {
        // Create a test record of the custom object
        CustomObj__c customObj = new CustomObj__c(Name = 'Test Record');
        insert customObj;

        // Instantiate the controller
        ApexPages.StandardController stdController = new ApexPages.StandardController(customObj);
        CustomObjExtController controller = new CustomObjExtController(stdController);

        Test.startTest();
        controller.onSubmit(); // Call the submit method
        Test.stopTest();

        // Optionally verify something if your logic changes record values
        // Currently, submit is just a call to SBAA.ApprovalAPI.submit(), which likely doesn’t update a field on the object
        // So here we check that the controller simply redirected
        PageReference result = controller.onSubmit();
        System.assertNotEquals(null, result);
        System.assert(result.getUrl().contains(customObj.Id));
    }

    @isTest
    static void testRecall() {
        // Create a test record of the custom object
        CustomObj__c customObj = new CustomObj__c(Name = 'Test Record');
        insert customObj;

        // Instantiate the controller
        ApexPages.StandardController stdController = new ApexPages.StandardController(customObj);
        CustomObjExtController controller = new CustomObjExtController(stdController);

        Test.startTest();
        controller.onRecall(); // Call the recall method
        Test.stopTest();

        // Similar to above, just check redirection
        PageReference result = controller.onRecall();
        System.assertNotEquals(null, result);
        System.assert(result.getUrl().contains(customObj.Id));
    }
}