public class Book_tgr_handler {
	public static void BEFORE_UPDATE(list<book__c> bookList,map<id,book__c> bookMap){
        for(Book__c book:bookList){
            if(book.SoldBooksCount__c!=bookMap.get(book.id).SoldBooksCount__c){
                book.Quantity__c-=(book.SoldBooksCount__c-bookMap.get(book.id).SoldBooksCount__c);
            }
        }
    } 
}