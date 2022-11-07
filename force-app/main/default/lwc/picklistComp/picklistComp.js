import { LightningElement, api, track } from 'lwc';
// import LWCDatatablePicklist from '@salesforce/resourceUrl/LWCDatatablePicklist';
export default class PicklistComp extends LightningElement {
  @api placeholder;
  @api options;
  @api value;
  @api context;
  @api label;
  @api id;
  @track showPicklist = false;
  connectedCallback() {

    this.id = this.id.slice(0, -4);
    console.log('id is', this.id);

    console.log(this.value);
    this.placeholder = this.value;
  }

  handleChange(event) {

    this.value = event.detail.value;

    console.log('on change book Id is', this.id);

    const childEvent = new CustomEvent('picklistchanged', {
      bubbles: true,
      composed: true,
      cancelable: true,
      detail: {
        Quant: parseInt(this.value), Bookid: this.id

      }
    })
    this.dispatchEvent(childEvent);

  }

}