trigger FeedbackTrigger on FeedBack__c (after insert) {

    if(Trigger.Isafter && Trigger.IsInsert)
    {
        system.debug('after-insert');
        FeedbackTriggerHelper.UpdateContactFields(Trigger.New);    
    }
}