@istest
public class LibraryCartHelper_Test {
    @istest
    Public Static void getBooksByLimit_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20);
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4600',IsActive__c=true,UnitPrice__c=20);
        Book__C book3=new book__C(Name='Bname3',Code__c='b-4700',IsActive__c=true,UnitPrice__c=20);
        insert book1;
        insert book2;
        insert book3;
        test.startTest();
        List<Book__c> BookList=LibraryCartHelper.getBooksByLimit(2);
        test.stopTest();
        system.assertEquals(2, BookList.size());
    }
    @istest
    Public Static void getAllContact_test(){
        Contact con1=new contact(LastName='Con1');
        Contact con2=new contact(LastName='Con2');
        insert con1;
        insert con2;
        test.startTest();
        List<contact> con= LibraryCartHelper.getAllContact();
        test.stopTest();
        system.assertEquals(2, Con.size());
    }
    @istest
    public static void getAllBooks_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20);
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4600',IsActive__c=false,UnitPrice__c=20);
        Book__C book3=new book__C(Name='Bname3',Code__c='b-4700',IsActive__c=true,UnitPrice__c=20);
        insert book1;
        insert book2;
        insert book3;
        test.startTest();
        List<Book__c> BookList=LibraryCartHelper.getAllBooks();
        test.stopTest();
        system.assertEquals(2, BookList.size());
    }
    @istest
    public static void SearchBooksByName_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20,Description__c='t');
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4600',IsActive__c=false,UnitPrice__c=20,Description__c='t');
        Book__C book3=new book__C(Name='Bname3',Code__c='b-4700',IsActive__c=true,UnitPrice__c=20,Description__c='t');
        Book__C book4=new book__C(Name='Bname4',Code__c='b-4800',IsActive__c=true,UnitPrice__c=20,Description__c='hi this is test Bname1 is the word');
        insert book1;
        insert book2;
        insert book3;
        insert book4;
        String searchText='Bname';
        test.startTest();
        List<Book__c> BookList=LibraryCartHelper.SearchBooksByName(searchText);
        searchText='Bname1';
        List<Book__c> BookList2=LibraryCartHelper.SearchBooksByName(searchText);
        test.stopTest();
        system.assertEquals(3, BookList.size());
        system.assertEquals(2, BookList2.size());
    }
    @istest
    public static void GetThreeBooks_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20);
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4600',IsActive__c=true,UnitPrice__c=20);
        Book__C book3=new book__C(Name='Bname3',Code__c='b-4700',IsActive__c=true,UnitPrice__c=20);
        Book__C book4=new book__C(Name='Bname4',Code__c='b-4800',IsActive__c=true,UnitPrice__c=20);
        Book__C book5=new book__C(Name='Bname5',Code__c='b-4900',IsActive__c=true,UnitPrice__c=20);
        Book__C book6=new book__C(Name='Bname6',Code__c='b-5000',IsActive__c=true,UnitPrice__c=20);
        insert book1;
        insert book2;
        insert book3;
        insert book4;
        insert book5;
        insert book6;
        test.startTest();
        List<book__c> bookList1=LibraryCartHelper.GetThreeBooks(0);
        list<book__c> bookList2=LibraryCartHelper.GetThreeBooks(3);
        test.stopTest();
        system.assertEquals('Bname1',bookList1[0].Name);
        system.assertEquals('Bname4',bookList2[0].Name);        
    }
    @istest
    Public static void GetNBooks_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20);
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4600',IsActive__c=true,UnitPrice__c=20);
        Book__C book3=new book__C(Name='Bname3',Code__c='b-4700',IsActive__c=true,UnitPrice__c=20);
        Book__C book4=new book__C(Name='Bname4',Code__c='b-4800',IsActive__c=true,UnitPrice__c=20);
        Book__C book5=new book__C(Name='Bname5',Code__c='b-4900',IsActive__c=true,UnitPrice__c=20);
        Book__C book6=new book__C(Name='Bname6',Code__c='b-5000',IsActive__c=true,UnitPrice__c=20);
        insert book1;
        insert book2;
        insert book3;
        insert book4;
        insert book5;
        insert book6;
        test.startTest();
        List<book__c> bookList1=LibraryCartHelper.GetNBooks(5);
        List<book__c> bookList2=LibraryCartHelper.GetNBooks(7);
        test.stopTest();
        system.assertEquals(5,bookList1.size());
        system.assertEquals(6,bookList2.size());        
    }
    @istest
    public static void CreateRecordsLwc_test(){
        Contact Con=new Contact(LastName='Con1');
        insert con;
        book__c book=new book__c(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20,Quantity__c=10);
        insert book;
        LibraryCartHelper.Wrapper data=new LibraryCartHelper.Wrapper();
        data.Book=book.Id;
        data.Name=book.Name;
        data.Quantity=5;
        data.UnitPrice=integer.valueOf(book.UnitPrice__c);
        list< LibraryCartHelper.Wrapper> warapperList=new list< LibraryCartHelper.Wrapper>();
        warapperList.add(data);
        test.startTest();
        LibraryCartHelper.CreateRecordsLwc(warapperList, con.Id);
        test.stopTest();
        order__c ord=[select id,Order_Amount__c from order__c];
        system.assertEquals(100, ord.Order_Amount__c);
    }
    
}