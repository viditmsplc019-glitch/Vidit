import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccounts from '@salesforce/apex/AccountContactController.getAccounts';
import getContactsByAccount from '@salesforce/apex/AccountContactController.getContactsByAccount';

export default class navigateAccCon extends NavigationMixin(LightningElement) {
    @track accountOptions = [];
    @track selectedAccountId;
    @track contacts = [];
    @track selectedContacts = [];

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Phone', fieldName: 'Phone' }
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
    const baseUrl = window.location.origin;

    this.selectedContacts.forEach(contact => {
        const contactEditUrl = `${baseUrl}/lightning/r/Contact/${contact.Id}/edit`;
        window.open(contactEditUrl, '_blank');
    });
}

}