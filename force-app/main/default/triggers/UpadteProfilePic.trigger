trigger UpadteProfilePic on Attachment (after insert) {
    
    if(Trigger.Isafter && Trigger.IsInsert)
    {
        system.debug('after Insert fired');
        UpadteProfilePicHelper.CreateLinkForAtt(Trigger.New);
        
    }   
}