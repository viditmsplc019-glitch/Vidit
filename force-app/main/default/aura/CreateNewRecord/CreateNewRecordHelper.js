({
    fetchContacts: function(component, event, helper) {
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
    },

    saveContacts: function(component, event, helper) {
        var contactList = component.get("v.contactList");
        var recordViewForm = component.find('recordViewForm');
        var recordEditForm = component.find('recordEditForm'); 
        var toastEvent = $A.get('e.force:showToast');
        var saveAction = component.get("c.saveContactList");
        saveAction.setParams({ contactList: contactList });
        saveAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var dataMap = response.getReturnValue();
                if(dataMap.status=='success') {
                    $A.util.removeClass(recordViewForm,'formHide');
                    $A.util.addClass(recordEditForm,'formHide');
                    var btn = event.getSource();
                    btn.set('v.name','edit');
                    btn.set('v.label','Edit');
                    toastEvent.setParams({
                        'title': 'Success!',
                        'type': 'success',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();            
                }
                else if(dataMap.status=='error') {
                    toastEvent.setParams({
                        'title': 'Error!',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();                
                }
            }
            else {
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(saveAction);
    },
    
    removeContacts: function(component, event, helper) {
        var contactsToDelete = component.find("deleteContact");
        var idsToDelete = [];
        if(contactsToDelete.length!=undefined) {
            for(var i=0;i<contactsToDelete.length;i++) {
                if(contactsToDelete[i].get("v.checked"))            
                    idsToDelete.push(contactsToDelete[i].get("v.value"));
            }            
        } else {
            if(contactsToDelete.get("v.checked"))            
                idsToDelete.push(contactsToDelete.get("v.value"));            
        }
        var toastEvent = $A.get('e.force:showToast');
        var deleteAction = component.get('c.deleteContactList');
        deleteAction.setParams({
            contactIds: idsToDelete
        });
        deleteAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var dataMap = response.getReturnValue();
                if(dataMap.status=='success') {
                    toastEvent.setParams({
                        'title': 'Success!',
                        'type': 'success',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();            
	                window.location.reload();
                }
                else if(dataMap.status=='error') {
                    toastEvent.setParams({
                        'title': 'Error!',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();                
                }
            }
            else {
                alert('Error in getting data');
            }            
        });
        $A.enqueueAction(deleteAction);
    },

    insertContact: function(component, event, helper) {
        var contact = component.get("v.contact");
        contact.AccountId = component.get('v.recordId');
        var toastEvent = $A.get('e.force:showToast');
        var createAction = component.get('c.createContactRecord');
        createAction.setParams({
            newContact: contact
        });
        createAction.setCallback(this, function(response) {           
            var state = response.getState();
            if(state === 'SUCCESS') {
                var dataMap = response.getReturnValue();
                if(dataMap.status=='success') {
                    toastEvent.setParams({
                        'title': 'Success!',
                        'type': 'success',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();            
                    window.location.reload();
                }
                else if(dataMap.status=='error') {
                    toastEvent.setParams({
                        'title': 'Error!',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();                
                }
            } else {
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(createAction);
    }
})