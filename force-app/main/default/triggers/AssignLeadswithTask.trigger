trigger AssignLeadswithTask on Lead (after update) {
    
    if(Trigger.IsAfter && Trigger.IsUpdate){
        UpdateLeadswithTaskHelper.creatingTaskForLead(Trigger.New);
        
        UpdateLeadswithTaskHelper.sendemailAttachonstatusupdate(Trigger.New);
    }
    
}