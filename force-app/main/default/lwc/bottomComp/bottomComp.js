import { LightningElement,api } from 'lwc';

export default class BottomComp extends LightningElement {
  @api showbookcount;
  @api showingrecords;
  @api numberoftotalbooks;
  @api showmorebutton;
  @api totalquantity;
  @api totalprice;

  ShowMoreRecords(){
    this.dispatchEvent(new CustomEvent('showmore'));
  }
  goToCart(){
    this.dispatchEvent(new CustomEvent('gotocart'));

  }
}