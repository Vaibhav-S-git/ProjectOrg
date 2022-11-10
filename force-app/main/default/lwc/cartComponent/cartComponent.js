import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CreateRecordsLwc from '@salesforce/apex/LibraryCartHelper.CreateRecordsLwc';
const actions = [
  { label: 'Add', name: 'Add' }
];

export default class CartComponent extends NavigationMixin(LightningElement) {
  CartColumns = [
    { label: 'Name', fieldName: 'Name' },
    {
      label: 'Quantity', type: 'picklistColumn', typeAttributes: {
        value: { fieldName: 'Quantity' },
        id: { fieldName: 'Book' },
        options: [
          { label: '1', value: '1' },
          { label: '2', value: '2' },
          { label: '3', value: '3' },
          { label: '4', value: '4' },
          { label: '5', value: '5' },
          { label: '6', value: '6' },
          { label: '7', value: '7' },
          { label: '8', value: '8' },
          { label: '9', value: '9' }
        ]
      }
    },
    { label: 'Unit Price', fieldName: 'UnitPrice' },
    { label: 'Total Price', fieldName: 'totalPrice' },
    {
      type: 'action',
      typeAttributes: { rowActions: actions },
    }
  ];
  //from parent
  @api booklist = [];

  @api totalquantity;
  @api totalprice;
  @api selectedcontact;

  @track ListOfBooks = [];


  @track disableButton = true;
  @api BookListUpdated;

  @api changedArray = [];
  @api SpinnerOn = false;
  @api ButtonTitle = 'Confirm Order';
  @api OrderId = '';
  connectedCallback() {
    this.ListOfBooks = JSON.parse(JSON.stringify(this.booklist));
    this.changedArray = this.ListOfBooks;
  }

  handleRowAction(event) {
    let row = event.detail.row;
    let bool = true;
  
    let copyList = [...this.changedArray];
   
    copyList.forEach(element => {

      if (element.avaliableBooks < row.Quantity && element.Book==row.Book) {
        bool = false;
        row.Quantity = row.totalPrice / row.UnitPrice;
        this.toastcall('error', 'Pick Less quantity', 'error');
      }
    });
    if (bool) {
      copyList.forEach(element => {

        if (element.Book == row.Book) {

          this.totalquantity -= row.totalPrice / row.UnitPrice;;
          this.totalprice -= row.totalPrice;
          element.totalPrice = parseInt(row.Quantity) * parseInt(row.UnitPrice);
          this.totalquantity += parseInt(row.Quantity);
          this.totalprice += parseInt(row.Quantity) * parseInt(row.UnitPrice);
          element.Quantity = ""+row.Quantity;
        }
      });
     
      this.ListOfBooks = [...copyList];
     
    }
  }

  picklistChanged(childEvent) {

    let quantityFromChild= childEvent.detail.Quant;
    let bookFromChild=childEvent.detail.Bookid;

    this.changedArray.forEach(element => {
      if (element.Book == bookFromChild) {
        
        element.Quantity = quantityFromChild;
      }
   
    });
    // this.ListOfBooks = this.changedArray;
  }
  OnConfirmation() {
    this.SpinnerOn = true;

    let con = this.selectedcontact;
    CreateRecordsLwc({ data: this.ListOfBooks, conId: con })
      .then(result => {
        // Clear the user enter values
        this.OrderId = result;
        this.SpinnerOn = false;
        this.ButtonTitle = 'Order confirmed'
        this.NavigateToOrder(this.OrderId);
        this.toastcall('Success!!', 'Order Created Successfully', 'success');
      })
      .catch(error => {
        console.debug(error.message);
        this.SpinnerOn = false;
      });
  }
  NavigateToOrder(OrdId) {
    console.log(OrdId);
    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
        recordId: OrdId,
        actionName: 'view'
      },
    });
  }
  toastcall(title, message, variant) {
    this.dispatchEvent(
      new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
      }),
    )
  }
}