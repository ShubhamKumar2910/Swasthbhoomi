public class googleauthclass{
    
    public string authtoken{get;set;}
    public string refereshtoken{get;set;}
    public string bodyprint{get;set;}
    //Settings needed on the google cloud console.One can store this securely in custom settings or an object.
 
    public static final string CLIENT_SECRET='3sv5ZjNeZBjIwyFy5izxLVUO';//Fill as per your registered app settings in google console
    public static final string CLIENT_ID='641447758190-8b29dgfibf9thivolg6uev6tklih68o9.apps.googleusercontent.com';//Fill as per your registered app settings in google console
    public static final string REDIRECT_URL='https://sales-production--healthcare.my.salesforce.com/apex/GoogleAuth';
    
    public static final string OAUTH_TOKEN_URL='https://accounts.google.com/o/oauth2/token';
    public static final string OAUTH_CODE_END_POINT_URL='https://accounts.google.com/o/oauth2/auth';
    
    public static final string GRANT_TYPE='grant_type=authorization_code';
    
    //Scope URL as per oauth 2.0 guide of the google 
    public static final string SCOPE='https://www.googleapis.com/auth/calendar';
    
    public pagereference connect(){
        String x=OAUTH_CODE_END_POINT_URL+'?scope='+EncodingUtil.urlEncode(SCOPE,'UTF-8')+'&access_type=offline'+'&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&response_type=code&client_id='+CLIENT_ID;
        pagereference p=new pagereference(x);
        return p;
    }
  
    public pagereference showtoken(){
        string codeparam=apexpages.currentpage().getparameters().get('code');
        // Instantiate a new http object
        Http h = new Http();
        String body='code='+codeparam+'&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&redirect_uri='+REDIRECT_URL+'&'+GRANT_TYPE;
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(OAUTH_TOKEN_URL);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setMethod('POST');
        req.setBody(body);
        system.debug('REQUEST BODY'+body);
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        system.debug('body'+res.getbody());
        //bodyprint=res.getbody();
        AccessTokenWrapper respWrapObj = AccessTokenWrapper.parse(res.getBody());
        System.debug('AccessToken' +respWrapObj.access_token);
        String AccToken = respWrapObj.access_token;
        
        GoogleMeetWrapper newWapper = new GoogleMeetWrapper();
        
        newWapper.summary = 'Testing_From_Apex';
        newWapper.description = 'One Last Round Of Testing From Apex';
        
        GoogleMeetWrapper.start st = new GoogleMeetWrapper.start();
        st.timeZone = 'Asia/Kolkata';
        st.date_Time = '2021-08-30T10:00:12Z';
        
        GoogleMeetWrapper.last lt = new GoogleMeetWrapper.last();
        lt.timeZone = 'Asia/Kolkata';
        lt.date_Time = '2021-08-30T10:10:12Z';
        
        
        GoogleMeetWrapper.conferenceSolutionKey cs = new GoogleMeetWrapper.conferenceSolutionKey();
        cs.type = 'hangoutsMeet';
        
        GoogleMeetWrapper.createRequest cr = new GoogleMeetWrapper.createRequest();
        cr.conferenceSolutionKey = cs;
        cr.requestId = 'sample123';
        
        GoogleMeetWrapper.conferenceData cd = new GoogleMeetWrapper.conferenceData();
        cd.createRequest = cr;
        
        List<GoogleMeetWrapper.attendees> at = new List<GoogleMeetWrapper.attendees>();
        
        GoogleMeetWrapper.attendees at1 = new GoogleMeetWrapper.attendees();
        at1.email = 'kshubham.skr29@gmail.com';
        
        
        GoogleMeetWrapper.attendees at2 = new GoogleMeetWrapper.attendees();
        at2.email = 'ajeet.kumar6171@gmail.com';
        
        at.add(at1);
        at.add(at2);
        
        
        newWapper.start = st;
        newWapper.last = lt;
        newWapper.conferenceData = cd;
        newWapper.attendees = at;
        
        string jsonString = JSON.serialize(newWapper);
        System.debug('jsonString >>'+jsonString); 
        bodyprint = GoogleMeetIntegration.createMeeting(jsonString,AccToken);
        return null;
    }
}