import { api, LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

// import noHeader from '@salesforce/resourceUrl/NoHeader';
// import { loadStyle } from "lightning/platformResourceLoader";

//Call All apex methods for the component 
import getAllContact from '@salesforce/apex/LibraryCartHelper.getAllContact';
import getAllBooks from '@salesforce/apex/LibraryCartHelper.getAllBooks';
import SearchBooksByName from '@salesforce/apex/LibraryCartHelper.SearchBooksByName';
import GetNBooks from '@salesforce/apex/LibraryCartHelper.GetNBooks';

export default class LibraryCart extends NavigationMixin(LightningElement) {
  //All Variables defined
  @api AllContactFromApex;
  @api SelectedContact = ' ';

  @api searchValue = '';

  @api initialRecords;
  @api NumberOfTotalBooks = 0;

  @api totalSearchedRecords = 0;

  @api totalPrice = 0;
  @api TotalQuantity = 0;
  @api ShowingRecords = 3;

  @api BookList = [];
  @api BookListUpdated = [];


  //Bool variable
  @track SpinnerOn = true;
  @track ShowFirstPage = true;
  @track disableButton = true;
  @track showmoreButton = true;
  @track showBookCount = true;
  @api isSearch = false;

  //getting all contacts
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
  //saving selected contact
  handleTypeChange(event) {
    this.SelectedContact = event.detail.value;
  }

  @wire(getAllBooks)
  wiredBooks({ data,error }) {
    if (data) {
      this.data = data;
      this.NumberOfTotalBooks = data.length;  //storing number of all activated books
      this.error = undefined;
    }
    else if(error){
      console.error('check error here', error);
    }
  }

  @wire(GetNBooks,{ Lim:'$ShowingRecords'})
  BookByNumber({ data,error }) {
    if (data) {
      this.SpinnerOn = false;
      this.initialRecords = data;  
      this.error = undefined;
    }
    else if(error){
      console.error('check error here', error);
    }
  }
 
 

  handleSearch(event) {
    let searchCmp = this.template.querySelector(".searchCmp");
    this.searchValue = event.detail.value;
    if (this.searchValue == null || this.searchValue.length == 0) {
      this.SpinnerOn = true;
      searchCmp.setCustomValidity("");
      searchCmp.reportValidity();
      GetNBooks({ Lim: this.ShowingRecords })
        .then((result) => {
          this.initialRecords = result;
          this.SpinnerOn = false;
          this.error = undefined;
          this.showBookCount = true;
          if (this.ShowingRecords != this.NumberOfTotalBooks)
            this.showmoreButton = true;
        })
        .catch((error) => {
          this.error = error;
          this.initialRecords = undefined;
        });
    }
  }
  handleClickSearch() {
    let searchCmp = this.template.querySelector(".searchCmp");
    this.showBookCount = false;
    this.showmoreButton = false;
    this.SpinnerOn = true;
    if (this.searchValue.length > 1) {
      searchCmp.setCustomValidity("");
      searchCmp.reportValidity();
      
      SearchBooksByName({ searchKey: this.searchValue })
        .then((result) => {

          this.initialRecords = result;
          this.SpinnerOn = false;
          if (result.length < 1) {
            searchCmp.setCustomValidity("No Matching Result");
            searchCmp.reportValidity();
          }
        })
        .catch((error) => {
          this.SpinnerOn = false;
          console.debug(error);
        });
    }
    else {
      searchCmp.setCustomValidity("Type Something first");
      searchCmp.reportValidity();
      this.SpinnerOn = false;
    }
  }
  HandleChildChange(childEvent) {
    this.totalPrice = this.totalPrice + childEvent.detail.TotalPriceFromChild;
    this.TotalQuantity = this.TotalQuantity + childEvent.detail.quantityFromChild;

    let BookVar = { 'sobjectType': 'BookOrder__c' };

    BookVar.Book = childEvent.detail.BookId;
    BookVar.Name = childEvent.detail.BookName;
    BookVar.Quantity = childEvent.detail.quantityFromChild;
    BookVar.UnitPrice = childEvent.detail.UnitPrice;
    BookVar.totalPrice = childEvent.detail.TotalPriceFromChild;
    BookVar.avaliableBooks = childEvent.detail.avaliableBooks;
    this.BookList.push(BookVar);

  }

  handleChildRemoval(Removevent) {

    this.totalPrice -= Removevent.detail.TotalPriceFromChild;
    this.TotalQuantity -= Removevent.detail.quantityFromChild;
    this.BookList = this.BookList.filter(function (BookVar) {
      return BookVar.Book !== Removevent.detail.ItemId;
    });
  }

  ShowMoreRecords() {
    if (this.NumberOfTotalBooks > this.ShowingRecords) {
      if (this.NumberOfTotalBooks - this.ShowingRecords > 3) {
        this.ShowingRecords += 3;
        this.LoadMoreBooks();
      }
      else {
        this.ShowingRecords = this.NumberOfTotalBooks;
        this.LoadMoreBooks();
      }
    }
    else {
      this.showmoreButton = false;
    }
  }
  LoadMoreBooks() {
    this.SpinnerOn = true;
    if (this.NumberOfTotalBooks <= this.ShowingRecords) {
      this.showmoreButton = false;
    }
  }

  

  goToCart() {

    if (this.TotalQuantity == 0) {
      this.toastcall('Error', 'Please Add atleast one book', 'error');

    }
    if (this.SelectedContact == ' ') {
      this.toastcall('Error', 'Please Select a Student first', 'error');
    }
    if (!(this.SelectedContact == ' ') && this.TotalQuantity != 0) {
      this.toastcall('Success', 'Successfully added to cart', 'Success');

      this.ShowFirstPage = false;
      //call card component 
    }
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