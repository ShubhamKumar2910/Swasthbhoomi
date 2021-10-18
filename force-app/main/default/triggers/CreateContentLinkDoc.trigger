trigger CreateContentLinkDoc on ContentVersion (After Insert) {
    
    if(Trigger.IsAfter && Trigger.IsInsert)
    {
        system.debug('After Insert fired');
        ContentLinkDocHelper.CreateContentLinkDocHelper(Trigger.New);
        
    }    
    
}