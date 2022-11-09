trigger Book_tgr on Book__c (before insert,before update,before delete,
                             after insert, after update,after delete,
                             after undelete)
{
    switch on Trigger.Operationtype{
        when BEFORE_UPDATE{
            Book_tgr_handler.BEFORE_UPDATE(Trigger.new,trigger.oldMap);
        }
    }
}