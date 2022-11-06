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
      label: 'Quantity', fieldName: 'Quantity', editable: true, type: 'picklistColumn', typeAttributes: {
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

  @api ListOfBooks = [];


  @track disableButton = true;
  @api BookListUpdated;


  @api SpinnerOn = false;
  @api ButtonTitle = 'Confirm Order';
  @api OrderId = '';


  handleRowAction() { }
  connectedCallback() {
    this.ListOfBooks = JSON.parse(JSON.stringify(this.booklist));
    console.log('list data from parent', JSON.parse(JSON.stringify(this.booklist)));
  }

  // handleRowAction(event) {

  //   const row = event.detail.row;
  //   let temp = true;
  //   this.ListOfBooks.forEach(element => {
  //     if (element.Book == row.Book__c)
  //       temp = false;
  //   });
  //   if (temp) {
  //     let BookVar = { 'sobjectType': 'BookOrder__c' };
  //     BookVar.Book = row.Book__c;
  //     BookVar.Name = row.Name;
  //     BookVar.Quantity = row.Quantity__C;
  //     BookVar.UnitPrice = row.UnitPrice__c;
  //     BookVar.totalPrice = row.Quantity__C * row.UnitPrice__c;

  //     this.TotalQuantity += row.Quantity__C;
  //     this.totalPrice += row.totalPrice;
  //     // this.BookListUpdated.push(BookVar);
  //   }
  // }
  handleSave() { }
  handleCancel() { }

  OnConfirmation() {
    this.SpinnerOn = true;

    console.log(this.SelectedContact);
    let con=this.selectedcontact;
    console.log('conid is ',con);
    CreateRecordsLwc({ data: this.ListOfBooks, conId:con})
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