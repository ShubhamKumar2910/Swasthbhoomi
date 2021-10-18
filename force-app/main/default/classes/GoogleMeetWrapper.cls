public class GoogleMeetWrapper {
    public list<attendees> attendees{get;set;}
    public last last{get;set;}
    public conferenceData conferenceData{get;set;}
    public String summary{get;set;}
    public start start{get;set;}
    public String description{get;set;}
    public class start{
        public String timeZone{get;set;}
        public String date_Time{get;set;}
    }
    public class last{
        public String timeZone{get;set;}
        public String date_Time{get;set;}
    }
    public class createRequest{
        public conferenceSolutionKey conferenceSolutionKey{get;set;}
        public String requestId{get;set;}
    }
    public class conferenceSolutionKey{
        public String type{get;set;}
    }
    public class conferenceData{
        public createRequest createRequest{get;set;}
    }
    public class attendees{
        public String email{get;set;}
    }
}