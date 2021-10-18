public class Appointment_Booking_validation_Helper {
    public static void CheckAppointmentLimits(List<Appointment_Booking__c> AppList){
        Id ppe = AppList[0].Patient_Package_Enrollment__c;
        ID packageId = [select Package__c from Patient_Package_Enrollment__c where id = :ppe].Package__c;
        system.debug('packageId'+packageId);
        Id ConId = AppList[0].Patient__c;
        if(packageId != null){
            Decimal LimitofPackage = [SELECT Number_Of_Appontments__c FROM Product2 where id =:packageId].Number_Of_Appontments__c;
            Decimal noOfAppAlreadyDone = [SELECT count() FROM Appointment_Booking__c where Patient__c =:ConId and Patient_Package_Enrollment__c =:ppe ];
            
            
            system.debug('LimitofPackage'+LimitofPackage+'noOfAppAlreadyDone'+noOfAppAlreadyDone);
            for(Appointment_Booking__c app : AppList)
            {
                if(noOfAppAlreadyDone >= LimitofPackage)
                {
                    app.addError('Booking For this Package have Already been Completed!!Kindly purchase a new Package');
                    system.debug('Booking For this Package have Already been Completed!!Kindly purchase a new Package');
                }else{
                    Patient_Package_Enrollment__c ppes = new Patient_Package_Enrollment__c();
                    ppes.Id = ppe;
                    ppes.Number_of_Bookings_Done__c =noOfAppAlreadyDone+1;
                    update ppes;
                }
            }    
        }
    }
    public static void PackageEntryLimits(List<Appointment_Booking__c> AppList){
        
        for(Appointment_Booking__c app : AppList)
        {
            system.debug(app.Patient_Package_Enrollment__c);
            if(app.Patient_Package_Enrollment__c  == null)
            {
                app.addError('You Can Not Create an Appointment Without purchasing A Package');
                system.debug('You Can Not Create an Appointment Without purchasing A Package');
            }
        }
    }
    public static void UpdatingStatus(List<Appointment_Booking__c> AppList){
        List<Appointment_Booking__c> ListOfApp = new List<Appointment_Booking__c>();
        for(Appointment_Booking__c app : AppList)
        {
            system.debug(app.Patient_Package_Enrollment__c);
            if(app.Patient_Package_Enrollment__c  != null && app.Timing_Slot__c != null && app.Appointment_Date__c != null)
            {
                app.Status__c  = 'Waiting For Approval';
            }
        }
    }
    
    public static void UpdatingNumberOfPatients(List<Appointment_Booking__c> AppList){
        
        Set<Id> conIDs = new Set<Id>();
        for(Appointment_Booking__c app : AppList)
        {
            conIDs.add(app.Doctor__c);
        }
        List<Contact> ListOfDoctorToBeUpdated = new List<Contact>();
        List<Contact> ListOfDoctor = [Select Id,Number_of_Patients_Served__c from contact where Id IN:conIDs];
        
        
        
        for(Appointment_Booking__c apb :AppList){
            for(Contact con : ListOfDoctor){
                if(apb.Doctor__c == con.Id && apb.Status__c == 'Completed'){
                    Contact newCon = new Contact();
                    newCon.id = con.Id;
                    newCon.Number_of_Patients_Served__c = con.Number_of_Patients_Served__c+1;
                    ListOfDoctorToBeUpdated.add(newCon);
                }
            }
        }
        update ListOfDoctorToBeUpdated;
        
    }
}