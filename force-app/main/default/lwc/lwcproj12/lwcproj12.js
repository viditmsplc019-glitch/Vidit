import { LightningElement , track } from 'lwc';

export default class Lwcproj12 extends LightningElement {
    @track greeting =  "World";
    changeHandler(event){
        this.greeting = event.trget.value;
    }
}