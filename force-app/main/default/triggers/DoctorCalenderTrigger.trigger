trigger DoctorCalenderTrigger on Doctor_Calender__c (before insert,before delete) {
    
    
    if(Trigger.Isbefore && Trigger.IsInsert)
    {
        system.debug('IsbeforeIsInsert');
        DoctorCalenderTriggerHelper.UpdateCalenderDates(Trigger.New);
        
    }
    if(Trigger.Isafter && (Trigger.IsInsert || Trigger.IsUpdate) )
    {
        system.debug('IsAfterIsInsert');
       // Appointment_Booking_validation_Helper.UpdatingNumberOfPatients(Trigger.New);  
    }
}