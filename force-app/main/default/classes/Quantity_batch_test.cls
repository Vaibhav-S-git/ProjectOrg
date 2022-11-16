@istest
public class Quantity_batch_test {
    @istest
    Public Static void Increase_value(){
        book__c book1=TestDataFactory.CreateBook('Bname1','b-4500');
        book1.Quantity__c=0;
        book1.UnitPrice__c=20;
        book__c book2=TestDataFactory.CreateBook('Bname2','b-4600');
        book2.Quantity__c=0;
        book2.UnitPrice__c=20;
        book2.IsActive__c=false;
        list<book__c> listOfBooks= new List<book__c>();
        listOfBooks.add(book1);
        listOfBooks.add(book2);
        insert listOfBooks;
        test.startTest();
        Quantity_batch batch = new Quantity_batch(5); 
        database.executeBatch(batch);
        test.stopTest();
        book1=[select id,Quantity__c from book__c where Name='Bname1'];
        system.assertEquals(5,book1.Quantity__c);
        book2=[select id,Quantity__c from book__c where Name='Bname2'];
        system.assertEquals(0,book2.Quantity__c);
    }
}