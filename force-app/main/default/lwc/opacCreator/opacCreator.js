import { LightningElement, wire, track } from 'lwc';
import getProducts from '@salesforce/apex/OpacCreatorController.getProducts';
import getProductOpacs from '@salesforce/apex/OpacCreatorController.getProductOpacs';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import saveOpac from '@salesforce/apex/OpacCreatorController.saveOpac';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Product', fieldName: 'Product__r.Name', type: 'text' },
    { label: 'Min', fieldName: 'Min__c', type: 'number' },
    { label: 'Max', fieldName: 'Max__c', type: 'number' },
    { label: 'Price', fieldName: 'Price__c', type: 'currency' }
];

export default class OpacCreator extends LightningElement {
    @track selectedProductId;
    @track productOptions = [];
    @track columns = COLUMNS;
    opacs;

    @track showNewForm = false;
    @track newOpac = { Name: '', Min__c: '', Max__c: '', Price__c: '' };

    @wire(getProducts)
    wiredProducts({ error, data }) {
        if (data) {
            this.productOptions = data.map(prod => ({
                label: prod.Name,
                value: prod.Id
            }));
        } else if (error) {
            this.showToast('Error', 'Failed to load products', 'error');
        }
    }

    @wire(getProductOpacs, { productId: '$selectedProductId' })
    wiredOpacs(result) {
        this.opacs = result;
    }

    handleProductChange(event) {
        this.selectedProductId = event.detail.value;
        this.showNewForm = false; // hide form if product changed
    }

    handleNewClick() {
        if (!this.selectedProductId) {
            this.showToast('Error', 'Please select a product first', 'error');
            return;
        }
        this.newOpac = { Name: '', Min__c: '', Max__c: '', Price__c: '' };
        this.showNewForm = true;
    }

    handleCancel() {
        this.showNewForm = false;
    }

    handleInputChange(event) {
        const field = event.target.name;
        let value = event.target.value;

        // convert number fields appropriately
        if (field === 'Min__c' || field === 'Max__c' || field === 'Price__c') {
            value = value ? Number(value) : null;
        }

        this.newOpac = { ...this.newOpac, [field]: value };
    }

    async handleSave() {
        // Basic validation
        if (!this.newOpac.Name || !this.newOpac.Min__c || !this.newOpac.Max__c || !this.newOpac.Price__c) {
            this.showToast('Error', 'Please fill all fields', 'error');
            return;
        }
        if (this.newOpac.Min__c <= 0) {
            this.showToast('Error', 'Min value must be greater than zero', 'error');
            return;
        }
        if (this.newOpac.Min__c > this.newOpac.Max__c) {
            this.showToast('Error', 'Min cannot be greater than Max', 'error');
            return;
        }

        // Link the product id to newOpac.Product__c
        const opacToSave = { ...this.newOpac, Product__c: this.selectedProductId };

        try {
            await saveOpac({ opac: opacToSave });
            this.showToast('Success', `OPAC ${this.newOpac.Name} created successfully`, 'success');
            this.showNewForm = false;
            await refreshApex(this.opacs);
        } catch (error) {
            this.showToast('Error', error.body ? error.body.message : error.message, 'error');
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}