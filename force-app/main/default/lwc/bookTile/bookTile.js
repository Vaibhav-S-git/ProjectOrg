import { api, LightningElement, track } from 'lwc';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
export default class BookTile extends NavigationMixin(LightningElement) {
  @api book;
  @api Quant = 0;
  @api TotalPrice = 0;
  @track showAddButton = false;
  @track ShowDeleteButton = false;
  @track DisableCombobox = false;
  @track OutofStock=false;
  imageURL = 'https://st2.depositphotos.com/2769299/7314/i/950/depositphotos_73146765-stock-photo-a-stack-of-books-on.jpg';
  // connectedCallback(){

  // }
  connectedCallback() {
    if (this.book.Quantity__c == 0) {

      this.DisableCombobox = true;
      this.showAddButton = true;
      this.OutofStock=true;
   }
  }
  get QuantityOptions() {
    return [
      { label: '0', value: '0' },
      { label: '1', value: '1' },
      { label: '2', value: '2' },
      { label: '3', value: '3' },
      { label: '4', value: '4' },
      { label: '5', value: '5' },
      { label: '6', value: '6' },
      { label: '7', value: '7' },
      { label: '8', value: '8' },
      { label: '9', value: '9' }
    ];
  }
  QuantityChanged(event) {

    this.Quant = Number(event.detail.value);
    this.TotalPrice = this.Quant * this.book.UnitPrice__c;
  }

  RemoveChildBook() {
    this.template.querySelector('lightning-combobox').value = '0';
    this.DisableCombobox = false;
    this.ShowDeleteButton = false;
    const Removevent = new CustomEvent('quantityremoval', {
      detail: {
        quantityFromChild: Number(this.Quant),
        TotalPriceFromChild: Number(this.TotalPrice),
        ItemId: this.book.Id
  
      }
    })
    this.dispatchEvent(Removevent);
    this.showAddButton = false;
    this.Quant = 0;
  }
  HandleAdd() {
    let quantCmp = this.template.querySelector(".quantCmp");

    if (!(this.Quant > 0)) {
      quantCmp.setCustomValidity("Select quantity first");
      quantCmp.reportValidity();
    }
    else if (this.Quant > this.book.Quantity__c) {
    
      quantCmp.setCustomValidity("Less Books are available");
      quantCmp.reportValidity();
    }
    else {
      quantCmp.setCustomValidity("");
      quantCmp.reportValidity();
      this.DisableCombobox = true;
      this.ShowDeleteButton = true;
      this.showAddButton = true;

      this.AddToParent();
    }
  }
  AddToParent() {

    const childEvent = new CustomEvent('quantitychange', {
      detail: {
        BookId: this.book.Id,
        UnitPrice: this.book.UnitPrice__c,
        quantityFromChild: this.Quant,
        TotalPriceFromChild: this.TotalPrice,
        BookName: this.book.Name
      }
    }
    )

    this.dispatchEvent(childEvent);
  }
  HandleNav() {
    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
        recordId: this.book.Id,
        actionName: 'view'
      },
    });
  }
}
