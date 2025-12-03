import { LightningElement,track } from 'lwc';
export default class ModalPopupLWC extends LightningElement {
    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    submitDetails() {
        this.isModalOpen = false;
    }
}