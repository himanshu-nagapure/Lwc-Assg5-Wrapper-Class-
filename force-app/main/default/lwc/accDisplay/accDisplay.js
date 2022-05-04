import { LightningElement, wire, track } from 'lwc';
import getAllAccWithConCasesOpps from '@salesforce/apex/AccountWrapper.getAllAccWithConCasesOpps';

export default class AccDisplay extends LightningElement {
    @track accountsWithRelList;
    @track error;
    @wire(getAllAccWithConCasesOpps)
    wiredAccountsWithList({ error, data }) {
        if (data) {
            this.accountsWithRelList = data;
        } else if (error) {
            console.log(error);
            this.error = error;
        }
    }
}