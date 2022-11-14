import { LightningElement, api, wire } from 'lwc';
import getAllContact from '@salesforce/apex/LibraryCartHelper.getAllContact';
export default class TopComponent extends LightningElement {
  @api AllContactFromApex;


  @wire(getAllContact) wiredobjects({ error, data }) {
    if (data) {
      this.AllContactFromApex = data.map(value => {
        return {
          label: value.Name,
          value: value.Id
        }
      });
    }
    else if (error) {
      console.error('check error here', error);
    }
  }


  handleTypeChange(event) {
    const childEvent = new CustomEvent('studentchange', {
      detail: {
        value: event.detail.value

      }
    })
    this.dispatchEvent(childEvent);
  }
  handleSearch(event){
    const Searchevent = new CustomEvent('search', {
      detail: {
        value: event.detail.value
      }
    })
  }
  handleClickSearch(){
    this.dispatchEvent(new CustomEvent('searchcllick'));
  }
}