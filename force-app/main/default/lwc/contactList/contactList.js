import { LightningElement, wire } from 'lwc';
 import getContactList from '@salesforce/apex/ContactExp.getContactList';
 export default class contactList extends LightningElement {
     @wire(getContactList) 
     contacts;
 }