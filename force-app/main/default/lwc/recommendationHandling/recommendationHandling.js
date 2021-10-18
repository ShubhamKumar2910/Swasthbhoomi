import { LightningElement, wire, api, track} from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import getBookApps from '@salesforce/apex/RecommendationHelper.getBookApps';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

const columns = [
    {
        label: 'Doctor',
        fieldName: 'Doctor_Name__c',
        sortable: true

    },
    {
        label: 'Patient',
        fieldName: 'Patient_Name__c',
        sortable: true
    },
    {
        label: 'Package Enrolled',
        fieldName: 'Package_Enrolled__c',
        sortable: true
    },
    {
        label: 'Status',
        fieldName: 'Status__c',
        sortable: true
    },
    {
        label: 'Appointment Date',
        fieldName: 'Appointment_Date__c',
        type: 'text',
        sortable: true
    },
    {
        label: 'Timing',
        fieldName: 'Timing_Slot__c',
        sortable: true
    },
    {
        type: "button",
        fixedWidth: 150,
        typeAttributes: {
        label: 'Recommendations',
        title: 'Recommendations',
        name: 'Recommendations',
        value: 'Recommendations',
        variant: 'brand',
        class: 'scaled-down'
        }
    }
];

export default class LightningDatatableExample extends NavigationMixin(LightningElement) {
    @track value;
    @track error;
    @track data;
    @track appId;
    @api sortedDirection = 'asc';
    @api sortedBy = 'Name';
    @api searchKey = '';
    result;
    
    @track page = 1; 
    @track items = []; 
    @track data = []; 
    @track columns; 
    @track startingRecord = 1;
    @track endingRecord = 0; 
    @track pageSize = 10; 
    @track totalRecountCount = 0;
    @track totalPage = 0;
  
    @wire(getBookApps, {searchKey: '$searchKey', sortBy: '$sortedBy', sortDirection: '$sortedDirection'})
    wiredAccounts({ error, data }) {
        if (data) {
        
            this.items = data;
            this.totalRecountCount = data.length; 
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); 
            
            this.data = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;

            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }

    //clicking on previous button this method will be called
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
    }

    //clicking on next button this method will be called
    nextHandler() {
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);            
        }             
    }

    //this method displays records page by page
    displayRecordPerPage(page){

        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        this.data = this.items.slice(this.startingRecord, this.endingRecord);

        this.startingRecord = this.startingRecord + 1;
    }    
    
    sortColumns( event ) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        return refreshApex(this.result);
        
    }
  
    handleKeyChange( event ) {
        debugger;
        this.searchKey = event.target.value;
        return refreshApex(this.result);
    }

    managePresc(event){
        debugger;
        this.appId =  event.detail.row.Id; 

        const defaultValues = encodeDefaultFieldValues({
            Appointment_Booking__c: this.appId,
        });

            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Recommendation__c',
                    actionName: 'new'
            },
            state: {
                defaultFieldValues : defaultValues
            }
        });
    }
}