public class FeedbackTriggerHelper {
    public static void UpdateContactFields(List<FeedBack__c> FeedbackList){
        List<FeedBack__c> Fee = new List<FeedBack__c>();
        /*Set<Id> DoctorsId = new set<id>();
        for(FeedBack__c fe : FeedbackList){
            DoctorsId.add(fe.Booking_Ref__r.Doctor__c);
        }*/
        String drId = [select Doctor__c from Appointment_Booking__c where id =:FeedbackList[0].Booking_Ref__c].Doctor__c;
        
        system.debug('drId'+drId);
        Contact con = [select No_Of_Feedbacks__c,Rating__c from contact where id = :drId];
        
        Decimal TotalRating = (con.No_Of_Feedbacks__c*con.Rating__c + FeedbackList[0].Rating__c)/(con.No_Of_Feedbacks__c + 1);
        con.No_Of_Feedbacks__c = con.No_Of_Feedbacks__c+1;
        con.Rating__c = TotalRating;
        update con;
    }
}