import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountContactController.getAccounts';
import getContactsByAccount from '@salesforce/apex/AccountContactController.getContactsByAccount';

export default class AccountContactTabs extends LightningElement {
    @track accountOptions = [];
    @track selectedAccountId;
    @track contacts = [];
    @track selectedContacts = [];
    @track contactTabs = [];

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Phone', fieldName: 'Phone' },
    ];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(acc => ({
                label: acc.Name,
                value: acc.Id
            }));
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    handleTabActive() {
        // Clear contact tabs when coming back to Account tab
        // optional: this.contactTabs = [];
    }

    handleAccountChange(event) {
        this.selectedAccountId = event.detail.value;
        this.loadContacts();
    }

    loadContacts() {
        getContactsByAccount({ accountId: this.selectedAccountId })
            .then(result => {
                this.contacts = result;
                this.selectedContacts = [];
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
            });
    }

    handleRowSelection(event) {
        this.selectedContacts = event.detail.selectedRows;
    }

    handleModify() {
        // Add selected contacts as new tabs
        this.selectedContacts.forEach(contact => {
            const exists = this.contactTabs.some(tab => tab.id === contact.Id);
            if (!exists) {
                this.contactTabs.push({
                    id: contact.Id,
                    label: contact.Name
                });
            }
        });
    }
}