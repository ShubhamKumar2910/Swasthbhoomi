trigger Appointment_Booking_validation on Appointment_Booking__c (before insert,after insert,after Update) {

     if(Trigger.Isbefore && Trigger.IsInsert)
    {
        system.debug('IsbeforeIsInsert');
        Appointment_Booking_validation_Helper.PackageEntryLimits(Trigger.New);
        Appointment_Booking_validation_Helper.CheckAppointmentLimits(Trigger.New);
        Appointment_Booking_validation_Helper.UpdatingStatus(Trigger.New);
        
    }
     if(Trigger.Isafter && (Trigger.IsInsert || Trigger.IsUpdate) )
    {
        system.debug('IsAfterIsInsert');
        Appointment_Booking_validation_Helper.UpdatingNumberOfPatients(Trigger.New);  
    }
}