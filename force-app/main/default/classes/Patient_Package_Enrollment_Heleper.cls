public class Patient_Package_Enrollment_Heleper {
    public static void CreatePayment(List<Patient_Package_Enrollment__c> ppeList){
        List<Payments__c> PaymentsToBeInserted = new List<Payments__c>();
        for(Patient_Package_Enrollment__c ppe : ppeList){
            Payments__c pay = new Payments__c();
            pay.Price__c = ppe.Package_Amount__c;
            pay.Patient_Package_Enrollment__c = ppe.Id;
            pay.Transaction_Status__c = 'Successful';
            PaymentsToBeInserted.add(pay);
        }
        system.debug('PaymentsToBeInserted'+PaymentsToBeInserted);
        insert PaymentsToBeInserted;
    }
}