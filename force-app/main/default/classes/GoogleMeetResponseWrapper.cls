public class GoogleMeetResponseWrapper {
		public list<attendees> attendees{get;set;}
		public String hangoutLink{get;set;}
		public Integer sequence{get;set;}
		public organizer organizer{get;set;}
		public creator creator{get;set;}
		public start start{get;set;}
		public String description{get;set;}
		//public end end{get;set;}
		public String summary{get;set;}
		public String iCalUID{get;set;}
		public String updated{get;set;}
		public String htmlLink{get;set;}
		public String created{get;set;}
		public String status{get;set;}
		public conferenceData conferenceData{get;set;}
		public String id{get;set;}
		public reminders reminders{get;set;}
		public String etag{get;set;}
		public String eventType{get;set;}
		public String kind{get;set;}
	public class status{
		public String statusCode{get;set;}
	}
	public class start{
		public String timeZone{get;set;}
	///	public String dateTime{get;set;}
	}
	public class reminders{
		public Boolean useDefault{get;set;}
	}
	public class organizer{
		public Boolean self{get;set;}
		public String email{get;set;}
	}
	public class key{
		public String type{get;set;}
	}
	public class entryPoints{
		public String entryPointType{get;set;}
		public String label{get;set;}
		public String uri{get;set;}
	}
	/*public class end{
		public String dateTime{get;set;}
		public String timeZone{get;set;}
	}*/
	public class creator{
		public Boolean self{get;set;}
		public String email{get;set;}
	}
	public class createRequest{
		public String requestId{get;set;}
		public conferenceSolutionKey conferenceSolutionKey{get;set;}
		public status status{get;set;}
	}
	public class conferenceSolutionKey{
		public String type{get;set;}
	}
	public class conferenceSolution{
		public key key{get;set;}
		public String iconUri{get;set;}
		public String name{get;set;}
	}
	public class conferenceData{
		public conferenceSolution conferenceSolution{get;set;}
		public String conferenceId{get;set;}
		public list<entryPoints> entryPoints{get;set;}
		public String signature{get;set;}
		public createRequest createRequest{get;set;}
	}
	public class attendees{
		public Boolean self{get;set;}
		public Boolean organizer{get;set;}
		public String responseStatus{get;set;}
		public String email{get;set;}
	}
    
    public static GoogleMeetResponseWrapper parse(String json) {
		return (GoogleMeetResponseWrapper) System.JSON.deserialize(json, GoogleMeetResponseWrapper.class);
	}
}