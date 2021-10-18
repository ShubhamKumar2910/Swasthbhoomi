Public class ZoomApis {
    public String bodyprint{get;set;}
    public String pswrd{get;set;}
    public  void createMeeting() {
        
        ZoomApis.createMeetingWapper newWapper = new ZoomApis.createMeetingWapper();
        newWapper.topic = 'Test Topic';
        newWapper.type = 2;
        newWapper.start_time = '2021-04-21T16:54:14Z';
        newWapper.duration = 60;
        newWapper.timezone = 'Asia/Kolkata';
        string jsonString = JSON.serialize(newWapper);
        System.debug('jsonString >>'+jsonString); 
        
        String endPoint = 'https://api.zoom.us/v2/users/Kshubham.skr29@gmail.com/meetings';
        HttpRequest req = new HttpRequest();
        req.setBody(jsonString);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setHeader('Authorization', 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IkRRZ3NIOFJtUzZlWm9WVDdlU1RVVmciLCJleHAiOjE2MzAzMTc4NDAsImlhdCI6MTYyOTcxMzA1OX0.y4JYzR_NbSEX_f5stprvgzKySbSV7GF0XnJJQ1q807A');
        req.setEndpoint(endPoint); 
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 201){
           // bodyprint = res.getBody();
            ZoomResponseWrapper respWrapObj = ZoomResponseWrapper.parse(res.getBody());
            bodyprint = respWrapObj.join_url.substringBefore('?');
            pswrd = respWrapObj.join_url.substringAfter('?');
            pswrd = pswrd.replace('pwd=', 'Password : ');
            System.debug('Meeting Link >>>' +respWrapObj.join_url);
            System.debug('res pass >>>' +res.getBody());            
        }else{
            System.debug('res fail >>>' +res.getBody());
        }
    }
    
    public class createMeetingWapper{
        Public String topic {get;set;}
        Public Integer type {get;set;}
        Public String start_time {get;set;}
        Public Integer duration {get;set;}
        Public String timezone {get;set;}
        Public String password {get;set;}
    }
}