trigger Patient_Package_Enrollment on Patient_Package_Enrollment__c (after insert) {

     if(Trigger.Isafter && Trigger.IsInsert)
    {
        system.debug('after-insert');
        Patient_Package_Enrollment_Heleper.CreatePayment(Trigger.New);    
    }
}