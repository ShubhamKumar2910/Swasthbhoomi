public class DoctorCalenderTriggerHelper {
    
    public static void UpdateCalenderDates(List<Doctor_Calender__c> calList){
        
       /* List<Doctor_Calender__c> calListToBeUpdated = new List<Doctor_Calender__c>();
        for(Doctor_Calender__c docCal : calList){
            if(docCal.Schedule_Period__c == 'Weekly'){
                docCal.Start_Date__c = system.today().addDays(1); 
                docCal.End_Date__c = system.today().addDays(8); 
            }else if(docCal.Schedule_Period__c == 'Monthly'){
                docCal.Start_Date__c = system.today().addDays(1); 
                docCal.End_Date__c = system.today().addDays(30); 
            }else{
                docCal.Start_Date__c = system.today().addDays(1); 
                docCal.End_Date__c = system.today().addDays(2);
            }
            //calListToBeUpdated.add(docCal); 
        }
        //update calListToBeUpdated;*/
    }
}