@RestResource(urlMapping='/DoctorSchedule/*')
global with sharing class DoctorAvailibilty {
    @HttpGet
    global static String getAvailableSLotsOfDr() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String drId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        Date nextWeek = system.today().addDays(7);
        List <Appointment_Booking__c> docAppts = [SELECT Id,Weekday__c,Appointment_Date__c,Doctor__c,Package_Enrolled__c,Patient__c,Refund_Requested__c,Speciality__c,Status__c,Timing_Slot__c FROM Appointment_Booking__c where Doctor__c = :drId and Appointment_Date__c <:nextWeek];
        
        map<String,set<String>> scheduleForNextWeek  = new map<String,set<String>>();
        map<String,set<String>> weekTotalschedule = new map<String,set<String>>();
        map<String,set<String>> AvailableSlotsforDoctor  = new map<String,set<String>>();
        
        for(Appointment_Booking__c app :  docAppts){
            if(scheduleForNextWeek.containsKey(app.Weekday__c)){
                set<String> slotsForADay = scheduleForNextWeek.get(app.Weekday__c);
                system.debug('slotsForexistingDay'+slotsForADay);
                slotsForADay.add(app.Timing_Slot__c);
                scheduleForNextWeek.put(app.Weekday__c,slotsForADay);
                system.debug('slotsForADay'+slotsForADay);
            }else{
                scheduleForNextWeek.put(app.Weekday__c,new set<String>{app.Timing_Slot__c});
            }
        }
        system.debug('scheduleForNextWeek'+scheduleForNextWeek);
        
        List <Doctor_Calender__c> docCal = [SELECT Active__c,Appointment_Duration__c,Days__c,Doctor__c,End_Time__c,Schedule_Period__c,Start_Time__c FROM Doctor_Calender__c where Doctor__c = :drId And Active__c = true LIMIT 1];
        Integer numberOfSlots = docCal[0].End_Time__c.hour() - docCal[0].Start_Time__c.hour();
        integer slotDuration = 0;
        if(docCal[0].Appointment_Duration__c == '30 min')
        {
            numberOfSlots = numberOfSlots*2;
            slotDuration = 30;
        }else if(docCal[0].Appointment_Duration__c == '15 min'){
            numberOfSlots = numberOfSlots*4;
            slotDuration = 15;
        }else{
            numberOfSlots = integer.valueof(numberOfSlots/0.75);
            slotDuration = 45;
        }
        system.debug('numberOfSlots'+numberOfSlots);
        
        Time nextStartTime =  docCal[0].Start_Time__c;
        
        set<String> TimingSlots = new set<String>();
        
        for(Integer i=0;i<numberOfSlots;i++){
            String strtTime = string.valueOf(nextStartTime).substring(0,5);
            String endTime = string.valueOf(nextStartTime.addMinutes(Integer.valueOf(slotDuration))).substring(0,5);
            TimingSlots.add(strtTime+'-'+endTime);
            nextStartTime = nextStartTime.addMinutes(Integer.valueOf(slotDuration));
        }
        set<String> Weekdays = new set<String>{'Monday','Tuesday','Wednesday','Thursday','Friday'};
            //Making the Daily Schedule    
            for(String str : Weekdays){
                weekTotalschedule.put(str,TimingSlots);
            }
        //Removing the Booked Slots from the TotalSlots
        for(String str : weekTotalschedule.keyset()){
            if(scheduleForNextWeek.containsKey(str)){
                AvailableSlotsforDoctor.put(str,StringCustomUtility.removeListFromList(weekTotalschedule.get(str),scheduleForNextWeek.get(str)));
            }else{
                AvailableSlotsforDoctor.put(str,weekTotalschedule.get(str));
            }
        }
        //Converting the Data In JSON ::
        List<AppointmentSlotsAvailable> appslot = new List<AppointmentSlotsAvailable>();
        for(String str : AvailableSlotsforDoctor.keyset()){
            AppointmentSlotsAvailable appsslots= new AppointmentSlotsAvailable(str,AvailableSlotsforDoctor.get(str));
            appslot.add(appsslots);
        }
        string jsonstring = JSON.serialize(AvailableSlotsforDoctor);
        system.debug('jsonstring'+jsonstring);
        return  jsonstring;
    }
}