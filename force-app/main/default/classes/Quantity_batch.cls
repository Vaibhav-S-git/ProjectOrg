public class Quantity_batch implements Database.Batchable<sObject>{
    public integer increaseCount;
    public Quantity_batch(integer count) {
        increaseCount = count;
    }
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id,Quantity__c from Book__c Where IsActive__c=true';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Book__c> bookRecords) {
       
        List<Book__c> listToUpdate=new list<book__c>();
        for(Book__c book:bookRecords){
            book.Quantity__c+=increaseCount;
            listToUpdate.add(book);
        }
        Update listToUpdate;
    }   
    public void finish(Database.BatchableContext BC) {
        
    }
}