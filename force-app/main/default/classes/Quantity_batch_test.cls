@istest
public class Quantity_batch_test {
    @istest
    Public Static void Increase_value(){
        Book__C book1=new book__C(Name='Bname1',Code__c='b-4500',Quantity__c=0, IsActive__c=true ,UnitPrice__c=20);
        Book__C book2=new book__C(Name='Bname2',Code__c='b-4500',Quantity__c=0,IsActive__c=false,UnitPrice__c=20);
        insert book1;
        insert book2;
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