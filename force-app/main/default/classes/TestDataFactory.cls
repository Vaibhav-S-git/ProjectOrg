public  class TestDataFactory {
  
  public static book__c CreateBook(String name,String code ){
    book__c book =new book__c();
    book.Name=Name;
    book.Code__c=Code;
    book.IsActive__c=true;
    book.Quantity__c=20;
    return book;
  }
  
  public static contact CreateContact(String lName){
    contact con=new Contact(LastName=lName);
    return con;
  }
  public static order__C CreateOrder(string conId){
    Order__c order=new Order__c();
    order.Student__c=conId;
    order.Order_Date__c=date.today();
   return order;
  }
  public static BookOrder__c CreateBookOrder(String bookId,String ordId,String bookName,integer quantity){
    BookOrder__c ord=new  BookOrder__c();
    ord.Book__c=bookId;
    ord.Order__c=ordId;
    ord.Name=bookName;
    ord.Quantity__c=quantity;
    return ord;
  }
}