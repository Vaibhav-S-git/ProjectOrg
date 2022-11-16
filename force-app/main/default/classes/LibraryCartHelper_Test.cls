@istest
public class LibraryCartHelper_Test {
    @istest
    Public Static void getBooksByLimit_test(){
        List<book__c> listOfBooks=new list<book__c>();
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book2.IsActive__c=false;
        book__c  book3=TestDataFactory.CreateBook('Bname3','b-4700');
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        listOfBooks.add(book3);
        insert listOfBooks;
        test.startTest();
        List<Book__c> BookList=LibraryCartHelper.getBooksByLimit(2);
        test.stopTest();
        system.assertEquals(2, BookList.size());
    }
    @istest
    Public Static void getAllContact_test(){
        Contact con1=TestDataFactory.CreateContact('Con1');
        Contact con2=TestDataFactory.CreateContact('Con2');
        List<contact> conList = new List<contact> ();
        conList.add(con1);
        conList.add(con2);
        insert conList;
        test.startTest();
        List<contact> con= LibraryCartHelper.getAllContact();
        test.stopTest();
        system.assertEquals(2, Con.size(),'assertion error');
    }
    @istest
    public static void getAllBooks_test(){
        List<book__c> listOfBooks=new list<book__c>();
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book2.IsActive__c=false;
        book__c  book3=TestDataFactory.CreateBook('Bname3','b-4700');
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        listOfBooks.add(book3);
        insert listOfBooks;
        test.startTest();
        List<Book__c> bookList=LibraryCartHelper.getAllBooks();
        test.stopTest();
        system.assertEquals(2, BookList.size(),'assertion error');
    }
    @istest
    public static void SearchBooksByName_test(){
        List<book__c> listOfBooks=new list<book__c>();
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book1.Description__c='t';
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book2.Description__c='t';
        book2.IsActive__c=false;
        book__c  book3=TestDataFactory.CreateBook('Bname3','b-4700');
        book3.Description__c='t';
        book__c book4=TestDataFactory.CreateBook('Bname4','b-4800');
        book4.Description__c='hi this is test Bname1 is the word';
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        listOfBooks.add(book3);
        listOfBooks.add(book4);
        insert listOfBooks;
        
        String searchText='Bname';
        test.startTest();
        List<Book__c> bookList=LibraryCartHelper.SearchBooksByName(searchText);
        searchText='Bname1';
        List<Book__c> bookList2=LibraryCartHelper.SearchBooksByName(searchText);
        test.stopTest();
        system.assertEquals(3, BookList.size(),'assertion error');
        system.assertEquals(2, BookList2.size(),'assertion error');
    }
    @istest
    public static void GetThreeBooks_test(){
        List<book__c> listOfBooks=new list<book__c>();
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book__c  book3=TestDataFactory.CreateBook('Bname3','b-4700');
        book__c book4=TestDataFactory.CreateBook('Bname4','b-4600');
        book__c book5=TestDataFactory.CreateBook('Bname5','b-4700');
        book__c  book6=TestDataFactory.CreateBook('Bname6','b-4800');
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        listOfBooks.add(book3);
        listOfBooks.add(book4);
        listOfBooks.add(book6);
        listOfBooks.add(book5);
        insert listOfBooks;
        test.startTest();
        List<book__c> bookList1=LibraryCartHelper.GetThreeBooks(0);
        list<book__c> bookList2=LibraryCartHelper.GetThreeBooks(3);
        test.stopTest();
        system.assertEquals('Bname1',bookList1[0].Name,'assertion error');
        system.assertEquals('Bname4',bookList2[0].Name,'assertion error');        
    }
    @istest
    Public static void GetNBooks_test(){
        List<book__c> listOfBooks=new list<book__c>();
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book__c  book3=TestDataFactory.CreateBook('Bname3','b-4700');
        book__c book4=TestDataFactory.CreateBook('Bname4','b-4600');
        book__c book5=TestDataFactory.CreateBook('Bname5','b-4700');
        book__c  book6=TestDataFactory.CreateBook('Bname6','b-4800');
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        listOfBooks.add(book3);
        listOfBooks.add(book4);
        listOfBooks.add(book6);
        listOfBooks.add(book5);
        insert listOfBooks;
        test.startTest();
        List<book__c> bookList1=LibraryCartHelper.GetNBooks(5);
        List<book__c> bookList2=LibraryCartHelper.GetNBooks(7);
        test.stopTest();
        system.assertEquals(5,bookList1.size(),'assertion error');
        system.assertEquals(6,bookList2.size(),'assertion error');        
    }
    @istest
    public static void CreateRecordsLwc_test(){
        Contact con=TestDataFactory.CreateContact('Con1');
        insert con;
        book__c book=TestDataFactory.CreateBook('Bname1','b-4500');
        book.unitprice__c=20;
        insert book;
        LibraryCartHelper.Wrapper data=new LibraryCartHelper.Wrapper();
        data.Book=book.Id;
        data.Name=book.Name;
        data.Quantity=5;
        data.UnitPrice=integer.valueOf(book.UnitPrice__c);
        list< LibraryCartHelper.Wrapper> warapperList=new list< LibraryCartHelper.Wrapper>();
        warapperList.add(data);
        test.startTest();
        Id ordid=  LibraryCartHelper.CreateRecordsLwc(warapperList, con.Id);
        test.stopTest();
        order__c ord=[select id,Order_Amount__c from order__c];
        system.assertEquals(ordid, ord.id,'assertion error');
        system.assertEquals(100, ord.Order_Amount__c,'amount failed');
    }
    
}