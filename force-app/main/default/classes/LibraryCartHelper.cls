public with sharing class LibraryCartHelper {
    
    @AuraEnabled(cacheable=true)
    public static List<Book__C> getBooksByLimit(integer BookLim){
        return[SELECT id,Name,Description__c,UnitPrice__c,Quantity__c 
               FROM Book__C 
               WHERE IsActive__c=TRUE
               ORDER BY Name ASC
               LIMIT:BookLim ];
    }
    @AuraEnabled(cacheable=true)
    public static list<Contact> getAllContact()
    {
        return [SELECT Name 
                FROM Contact 
                ORDER BY Name ASC];
    }
    @AuraEnabled(cacheable=true)
    public static List<Book__C> getAllBooks(){
        return[SELECT id,Name,Description__c,UnitPrice__c,Quantity__c 
               FROM Book__C 
               WHERE IsActive__c=TRUE
               ORDER BY Name ASC];
    }
    @AuraEnabled
    public static list<Book__C> SearchBooksByName(String searchKey){
          List<Book__c> bookListReturn = new List<Book__c>();
        List<Book__c> bookList = new List<Book__c>( [SELECT id,Name,Description__c,UnitPrice__c,Quantity__c 
               FROM Book__C 
               WHERE IsActive__c= true
               ORDER BY Name ASC]);
              for (Book__c book :bookList ) {
                if (book.Description__c.contains(searchKey) || book.Name.contains(searchKey)) {
                    bookListReturn.add(book);
                }
              }
              return bookListReturn;
              
    }    
    @AuraEnabled(cacheable=true)
    public static list<Book__C> GetThreeBooks(integer OffsetVal){
        
        list<Book__C> bookList=[SELECT id,Name,Description__c,UnitPrice__c,Quantity__c 
                                FROM Book__C 
                                WHERE IsActive__c= TRUE
                                ORDER BY Name 
                                LIMIT 3 OFFSET:OffsetVal];
        system.debug(bookList);
        return bookList;	
    }
    @AuraEnabled(cacheable=true)
    public static list<Book__C> GetNBooks(integer Lim){
        
        list<Book__C> bookList=[SELECT id,Name,Description__c,UnitPrice__c,Quantity__c 
                                FROM Book__C 
                                WHERE IsActive__c= true
                                ORDER BY Name LIMIT :Lim];
        system.debug(BookList);
        return bookList;	
    }
    @AuraEnabled
    public static String CreateRecordsLwc(object data,string conId){
        list<wrapper> bookData=( list<wrapper>)JSON.deserialize(JSON.serialize(data),list<wrapper>.class);
        
        Order__c order=new Order__c();
        order.Student__c=conId;
        order.Order_Date__c=date.today();
        insert order;
        List<BookOrder__c> bookOrder=new List<BookOrder__c>();
        for(wrapper book:BookData){
            system.debug(book);
            BookOrder__c ord=new  BookOrder__c();
            ord.Order__c=order.Id;
            ord.Book__c=book.Book;
            ord.Name=book.Name;
            ord.Quantity__c=book.Quantity;
            BookOrder.add(ord);
        }
        insert BookOrder;
        system.debug(order.Id);
        return order.Id;
    }
    public class Wrapper{
        @AuraEnabled
        public String Book;
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public integer Quantity;
        @AuraEnabled
        public integer UnitPrice;
    }   
}