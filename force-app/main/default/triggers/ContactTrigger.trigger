trigger ContactTrigger on Contact (before insert) {
    
    if(Trigger.Isbefore && Trigger.IsInsert)
    {
        system.debug('after Insert fired');
        ContactTriggerHelper.CheckDuplicateEmail(Trigger.New);
        
    }   
}