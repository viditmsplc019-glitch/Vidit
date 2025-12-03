({
    fetchContacts : function(component, event, helper) {
        var action = component.get("c.getContactList");
        var accountId = component.get("v.recordId");
        action.setParams({
            accountIds: accountId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var contactList = response.getReturnValue();
                component.set("v.contactList",contactList);
            }
            else {
                alert('Error in getting data');
            }
        });
        
        $A.enqueueAction(action);
    }    
})