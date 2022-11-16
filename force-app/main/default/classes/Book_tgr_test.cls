@istest
public with sharing class Book_tgr_test {
    @istest
    public static void trigger_test(){
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book1.Quantity__c=20;
        book1.UnitPrice__c=20;
        insert book1;
        contact con=TestDataFactory.CreateContact('con');
        insert con;
        
        Order__c order= TestDataFactory.CreateOrder(con.Id);
        insert order;
        
        BookOrder__c ord=TestDataFactory.CreateBookOrder(book1.Id,order.Id,book1.Name,10);
        test.startTest();
        insert ord;
        test.stopTest();
        
        book__c book=[select Quantity__c from Book__c WHERE IsActive__c=true];
        system.assertEquals(10, book.Quantity__c, 'assertion failed');
        
    }
}