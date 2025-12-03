import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccounts from '@salesforce/apex/AccountContactController3.getAccounts';
import getLastModifiedContactsByAccount from '@salesforce/apex/AccountContactController3.getLastModifiedContactsByAccount';
import getContactsByAccount from '@salesforce/apex/AccountContactController3.getContactsByAccount';
import getContactById from '@salesforce/apex/AccountContactController3.getContactById';

export default class ContactEditor extends NavigationMixin(LightningElement) {
@track accountOptions = [];
@track selectedAccountId;
@track contacts = [];
@track selectedContactId = null;
@track showModal = false;
@track lastModifiedContact;
@track lastModifiedContactList = []; 

columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Last Modified', fieldName: 'LastModifiedDate', type: 'date' }
];

@wire(getAccounts)
wiredAccounts({ data, error }) {
    if (data) {
        this.accountOptions = data.map(acc => ({
            label: acc.Name,
            value: acc.Id
        }));
    } else if (error) {
        console.error('Error fetching accounts:', error);
    }
}

handleAccountChange(event) {
    this.selectedAccountId = event.detail.value;
    this.selectedContactId = null;
    this.fetchContacts();
}

fetchContacts() {
    getContactsByAccount({ accountId: this.selectedAccountId })
        .then(result => {
            this.contacts = result;
        })
        .catch(error => {
            console.error('Error fetching contacts:', error);
        });
}

handleRowSelection(event) {
    const selectedRows = event.detail.selectedRows;
    if (selectedRows.length > 0) {
        this.selectedContactId = selectedRows[0].Id;
    }
}

handleEdit() {
    if (!this.selectedContactId) {
        alert('Please select a contact.');
        return;
    }

    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.selectedContactId,
            objectApiName: 'Contact',
            actionName: 'edit'
        }
    });

setTimeout(() => {
getLastModifiedContactsByAccount({ accountId: this.selectedAccountId })
    .then(result => {
        this.lastModifiedContactList = result;
        this.showModal = true;
    })
    .catch(error => {
        console.error('Error fetching last modified contacts:', error);
    });
}, 3000);}


closeModal() {
    this.showModal = false;
    this.lastModifiedContact = null;
    this.lastModifiedContactList = [];
}
}