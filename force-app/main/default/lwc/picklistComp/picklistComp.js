import { LightningElement, api, track } from 'lwc';
// import LWCDatatablePicklist from '@salesforce/resourceUrl/LWCDatatablePicklist';
export default class PicklistComp extends LightningElement {
  @api placeholder;
  @api options;
  @api value;
  @api context;
  @api label;
  @track showPicklist = false;

 
  handleChange(event) {
    
    this.value = event.detail.value;

    
    this.dispatchEvent(new CustomEvent('picklistchanged', {
     
      detail: {
        data: { value: this.value }
      }
    }));
  }

}