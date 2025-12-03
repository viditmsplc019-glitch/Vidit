({
    fetchContacts: function(component, event, helper) {
        var action = component.get("c.getContactList");
        var accountId = component.get("v.recordId");

        action.setParams({
            accountIds: accountId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set("v.contactList", response.getReturnValue());
            } else {
                this.showToast("Error!", "Error retrieving contacts.", "error");
            }
        });

        $A.enqueueAction(action);
    },

    saveContacts: function(component, event, helper) {
        var contactList = component.get("v.contactList");
        var action = component.get("c.saveContactList");

        action.setParams({ contactList: contactList });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var dataMap = response.getReturnValue();
                if (dataMap.status === "success") {
                    $A.util.removeClass(component.find('recordViewForm'), 'formHide');
                    $A.util.addClass(component.find('recordEditForm'), 'formHide');

                    var btn = event.getSource();
                    btn.set("v.name", "edit");
                    btn.set("v.label", "Edit");

                    this.showToast("Success!", dataMap.message, "success");
                } else {
                    this.showToast("Error!", dataMap.message, "error");
                }
            } else {
                this.showToast("Error!", "Error saving contacts.", "error");
            }
        });

        $A.enqueueAction(action);
    },

    insertContact: function(component, event, helper) {
        var newContact = component.get("v.contact");
        var accountId = component.get("v.recordId");

        var action = component.get("c.createNewContact");
        newContact.AccountId = accountId;

        action.setParams({ contact: newContact });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.showToast("Success!", "New contact created successfully.", "success");
                this.fetchContacts(component, event, helper);
                component.set("v.contact", {
                    'SObjectType': 'Contact',
                    'FirstName': '',
                    'LastName': '',
                    'Email': '',
                    'Phone': ''
                });
                var modal = component.find("contactModal");
                var modalBackdrop = component.find("contactModalBackdrop");
                $A.util.removeClass(modal, "slds-fade-in-open");
                $A.util.removeClass(modalBackdrop, "slds-backdrop_open");
            } else {
                this.showToast("Error!", "Failed to create contact.", "error");
            }
        });

        $A.enqueueAction(action);
    },

    removeContacts: function(component, event, helper) {
        var checkboxes = component.find("deleteContact");
        var selectedIds = [];

        if (!Array.isArray(checkboxes)) {
            if (checkboxes.get("v.checked")) {
                selectedIds.push(checkboxes.get("v.value"));
            }
        } else {
            checkboxes.forEach(function(cb) {
                if (cb.get("v.checked")) {
                    selectedIds.push(cb.get("v.value"));
                }
            });
        }

        if (selectedIds.length === 0) {
            this.showToast("Warning", "Please select at least one contact to delete.", "warning");
            return;
        }

        var action = component.get("c.deleteContactsByIds");
        action.setParams({ contactIds: selectedIds });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.showToast("Deleted!", "Selected contact(s) deleted successfully.", "success");
                this.fetchContacts(component, event, helper);
            } else {
                this.showToast("Error!", "Error deleting contacts.", "error");
            }
        });

        $A.enqueueAction(action);
    },

    showToast: function(title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent) {
            toastEvent.setParams({
                "title": title,
                "message": message,
                "type": type
            });
            toastEvent.fire();
        } else {
            alert(title + ': ' + message); 
        }
    }
});