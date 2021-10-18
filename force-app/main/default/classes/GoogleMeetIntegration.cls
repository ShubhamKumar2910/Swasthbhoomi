public class GoogleMeetIntegration {
/*     
GoogleMeetWrapper newWapper = new GoogleMeetWrapper();
newWapper.summary = 'Testing_From_Apex';
newWapper.description = 'One Last Round Of Testing From Apex';
GoogleMeetWrapper.start st = new GoogleMeetWrapper.start();
st.timeZone = 'Asia/Kolkata';
st.date_Time = '2021-08-27T02:12:12Z';
GoogleMeetWrapper.last lt = new GoogleMeetWrapper.last();
lt.timeZone = 'Asia/Kolkata';
lt.date_Time = '2021-08-27T02:12:12Z';
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
at2.email = 'vaishali.bishnoi55541@gmail.com';
at.add(at1);
at.add(at2);
newWapper.start = st;
newWapper.last = lt;
newWapper.conferenceData = cd;
newWapper.attendees = at;
string jsonString = JSON.serialize(newWapper);
System.debug('jsonString >>'+jsonString); 
*/
    public static string createMeeting(String jasonString,String AccessToken) {
        jasonString = jasonString.replace('"last":', '"end":');
        jasonString = jasonString.replace('"date_Time":', '"dateTime":');
        System.debug('jason>>'+jasonString);
        
        String endPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events?conferenceDataVersion=1';
        HttpRequest req = new HttpRequest();
        req.setBody(jasonString);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setHeader('Accept', 'application/json');
        req.setHeader('key', 'AIzaSyDLdmQ75IFogsLG1yjBc3iy0oipBMFol_I');
        req.setHeader('Authorization', 'Bearer '+AccessToken);
        req.setEndpoint(endPoint); 
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 201 || res.getStatusCode() == 200){
            GoogleMeetResponseWrapper respWrapObj = GoogleMeetResponseWrapper.parse(res.getBody());
            System.debug('Meeting Link >>>' +respWrapObj.htmlLink);
            return respWrapObj.htmlLink; 
            //            
        }else{
            System.debug('res fail >>>' +res.getBody());
            return 'fail';
        }
    }
}