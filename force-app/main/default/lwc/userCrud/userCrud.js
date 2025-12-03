import { LightningElement, track, wire } from 'lwc';
import getUsers from '@salesforce/apex/UserController.getUsers';
import createUser from '@salesforce/apex/UserController.createUser';
import updateUser from '@salesforce/apex/UserController.updateUser';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Username', fieldName: 'Username' },
    { label: 'Active', fieldName: 'IsActive' , type: 'boolean'},
    { label: 'Email', fieldName: 'Email' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Edit',
            name: 'edit',
            title: 'Edit',
            variant: 'brand'
        }
    }
];

export default class UserCrud extends LightningElement {
    @track users = [];
    @track form = {};
    @track isModalOpen = false;
    @track isEditMode = false;
    columns = COLUMNS;
    modalTitle = 'New User';
    wiredUsersResult;

    @wire(getUsers)
    wiredUsers(result) {
        this.wiredUsersResult = result;
        const { data } = result;
        if (data) {
            this.users = data;
        }
    }

    openNewUserModal() {
        this.form = {};
        this.isEditMode = false;
        this.modalTitle = 'Create New User';
        this.isModalOpen = true;
    }

    handleRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;
        if (action === 'edit') {
            this.form = { ...row };
            this.isEditMode = true;
            this.modalTitle = 'Edit User';
            this.isModalOpen = true;
        }
    }

    handleInputChange(event) {
        this.form = {
            ...this.form,
            [event.target.name]: event.target.value
        };
    }

    closeModal() {
        this.isModalOpen = false;
    }

    async handleSave() {
        try {
            if (this.isEditMode) {
                await updateUser({ userData: this.form });
            } else {
                await createUser({ userData: this.form });
            }
            this.isModalOpen = false;
            await refreshApex(this.wiredUsersResult);
        } catch (error) {}
    }
}