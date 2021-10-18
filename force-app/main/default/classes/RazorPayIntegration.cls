public class RazorPayIntegration {
    
    public string bodyprint{get;set;}
    
    public  void GeneratepaymentLink(){
        RazorPayWrapper newWapper = new RazorPayWrapper();
        newWapper.description = 'HealthCare-Topic';
        newWapper.reference_id = 'Taad1826';
        newWapper.expire_by = 1691097057;
        newWapper.reminder_enable = true;
        newWapper.first_min_partial_amount = 100;
        newWapper.accept_partial = true;
        newWapper.callback_url = 'https://www.google.com/';
        newWapper.callback_method = 'get';
        newWapper.amount = 1000;
        
        RazorPayWrapper.notify nf =new RazorPayWrapper.notify();
        nf.sms = true;
        nf.email = true;
        
        RazorPayWrapper.notes nt = new RazorPayWrapper.notes();
        nt.policy_name = 'Jeevan Bima';
        
        RazorPayWrapper.customer ct = new RazorPayWrapper.customer();
        ct.email = 'kshubham.skr29@gmail.com';
        ct.contact = '+917353048304';
        ct.name = 'shubham kumar';
        
        newWapper.notify = nf;
        newWapper.notes = nt;
        newWapper.customer = ct;
        
        string jsonString = JSON.serialize(newWapper);
        System.debug('jsonString >>'+jsonString); 
        String PayLink = RazorPayIntegration.createpayment(jsonString);
        bodyprint = PayLink;
        System.debug('PayLink >>'+PayLink);
    }
    
    public static String createpayment(String jasonString) {
        System.debug('jason>>'+jasonString);
        //https://api.zoom.us/v2/users/{userId}
        String endPoint = 'https://api.razorpay.com/v1/payment_links';
        HttpRequest req = new HttpRequest();
        req.setBody(jasonString);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setHeader('Authorization', 'Basic cnpwX3Rlc3RfUFBoTVJGa2NKclVtZGo6dGZSV2ZMRjZsSjA3d2VFYkgxcGhGRTVL');
        req.setEndpoint(endPoint); 
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 201 || res.getStatusCode() == 200){
            RazorPayResponseWrapper respWrapObj = RazorPayResponseWrapper.parse(res.getBody());
            System.debug('Meeting Link >>>' +respWrapObj.short_url);
            return respWrapObj.short_url; 
           
        }else{
            System.debug('res fail >>>' +res.getBody());
            return 'Fail';
        }
    }
}