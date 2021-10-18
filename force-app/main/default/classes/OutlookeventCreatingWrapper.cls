public class OutlookeventCreatingWrapper {
    public ends ends{get;set;}
    public location location{get;set;}
    public list<attendees> attendees{get;set;}
    public start start{get;set;}
    public Boolean allowNewTimeProposals{get;set;}
    public body body{get;set;}
    public String transactionId{get;set;}
    public String subject{get;set;}
    public class start{
        public String timeZone{get;set;}
        public String dateTimes{get;set;}
    }
    public class location{
        public String displayName{get;set;}
    }
    public class ends{
        public String timeZone{get;set;}
        public String dateTimes{get;set;}
    }
    public class emailAddress{
        public String address{get;set;}
        public String name{get;set;}
    }
    public class body{
        public String content{get;set;}
        public String contentType{get;set;}
    }
    public class attendees{
        public emailAddress emailAddress{get;set;}
        public String type{get;set;}
    }
    public static OutlookeventCreatingWrapper parse(String json) {
		return (OutlookeventCreatingWrapper) System.JSON.deserialize(json, OutlookeventCreatingWrapper.class);
	}
}