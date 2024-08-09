import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import updateRecords from '@salesforce/apex/AccountController.updateRecords';

export default class AccountTable extends LightningElement {
    @track columns = [
        { label: 'Name', fieldName: 'Name', editable: true },
        { label: 'Industry', fieldName: 'Industry', editable: true },
        { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency', editable: true }
    ];
    @track draftValues = [];

    @wire(getAccounts)
    accounts;

    handleUpdateRecords(event) {
        const updatedFields = event.detail.draftValues;
        
        updateRecords({ accountsToUpdate: updatedFields })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Accounts updated',
                        variant: 'success'
                    })
                );
                this.draftValues = [];
                return refreshApex(this.accounts);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating records',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}