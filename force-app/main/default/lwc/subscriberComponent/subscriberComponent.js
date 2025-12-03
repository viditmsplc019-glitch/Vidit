import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import EXAMPLE_CHANNEL from '@salesforce/messageChannel/ExampleChannel__c';


export default class SubscriberComponent extends LightningElement {
    receivedMessage = 'No message received yet';
    subscription = null;


    @wire(MessageContext)
    messageContext;


    connectedCallback() {
        this.subscribeToMessageChannel();
    }


    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            EXAMPLE_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }


    handleMessage(msg) {
        this.receivedMessage = msg.message;
    }


    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}