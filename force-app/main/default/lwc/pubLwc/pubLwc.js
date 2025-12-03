import { LightningElement,wire} from 'lwc';
import {publish,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';
export default class PubLwc extends LightningElement {


@wire(MessageContext)
    messageContext;


    add(){
        const payload={
            operator:'add',
            constant:1
        };
                publish(this.messageContext,COUNTING_UPDATED_CHANNEL,payload);
    }
     subtract(){
        const payload={
            operator:'subtract',
            constant:1


        };
                publish(this.messageContext,COUNTING_UPDATED_CHANNEL,payload);




    }


    multiply(){
            const payload={
            operator:'multiply',
            constant:2
        };
                publish(this.messageContext,COUNTING_UPDATED_CHANNEL,payload);


    }
    divide(){
            const payload={
            operator:'divide',
            constant:2
        };
                publish(this.messageContext,COUNTING_UPDATED_CHANNEL,payload);


    }
    clear() {
    const payload = {
        operator: 'clear',
        constant: 0
    };
    publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
}
    percentage() {
        const payload = {
            operator: 'percentage',
            constant: 10
        };
        publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
        }
}