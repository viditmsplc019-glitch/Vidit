import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import EXAMPLE_CHANNEL from '@salesforce/messageChannel/ExampleChannel__c';


export default class PublisherComponent extends LightningElement {
    messageText = '';


    @wire(MessageContext)
    messageContext;


    handleMessageChange(event) {
        this.messageText = event.target.value;
    }


    publishMessage() {
        const payload = {
            message: this.messageText
        };
       
        publish(this.messageContext, EXAMPLE_CHANNEL, payload);
    }
}