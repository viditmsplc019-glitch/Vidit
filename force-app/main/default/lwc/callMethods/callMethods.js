import { LightningElement, track } from 'lwc';
import methodA from '@salesforce/apex/ExampleApex.methodA';
import methodB from '@salesforce/apex/ExampleApex.methodB';
import methodC from '@salesforce/apex/ExampleApex.methodC';

export default class CallMethods extends LightningElement {
    @track failA = false;
    @track failB = false;
    @track failC = false;

    @track aResult;
    @track bResult;
    @track cResult;
    @track errorMsg;
    @track loading = false;

    handleToggle(event) {
        const { name, checked } = event.target;
        this[name] = checked;
    }

    async runMethods() {
        this.loading = true;
        this.aResult = this.bResult = this.cResult = this.errorMsg = null;

        try {
            // CALL A
            const aResp = await methodA({ failA: this.failA });
            this.aResult = aResp;
            if (!aResp) {
                this.errorMsg = '❌ Method A failed — stopping';
                this.loading = false;
                return;
            }

            // CALL B
            const bResp = await methodB({ failB: this.failB });
            this.bResult = bResp;
            if (!bResp) {
                this.errorMsg = '❌ Method B failed — stopping';
                this.loading = false;
                return;
            }

            // CALL C
            const cResp = await methodC({ failC: this.failC });
            this.cResult = cResp;

        } catch (error) {
            this.errorMsg = '⚠️ Error: ' + (error.body?.message || error);
        }

        this.loading = false;
    }
}