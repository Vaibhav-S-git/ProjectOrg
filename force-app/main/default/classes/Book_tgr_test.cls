@istest
public with sharing class Book_tgr_test {
    @istest
    public static void trigger_test(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',IsActive__c=true,UnitPrice__c=20,Quantity__c=20);
        insert book1;
        system.debug(book1.Id);
        contact con=new contact(Lastname='con');
        insert con;
        
        Order__c order=new Order__c();
        order.Student__c=con.Id;
        order.Order_Date__c=date.today();
        insert order;
        
        
        BookOrder__c ord=new  BookOrder__c();
        ord.Book__c=book1.Id;
        ord.Order__c=order.Id;
        ord.Name=book1.Name;
        ord.Quantity__c=10;
        test.startTest();
        insert ord;
        test.stopTest();
        
        book__c book=[select Quantity__c from Book__c WHERE IsActive__c=true];
        system.assertEquals(10, book.Quantity__c, 'assertion failed');
        
    }
}
