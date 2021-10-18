public class LightningProcessBuilder {
    @InvocableMethod(label='Get Enrolments' description='Iterate over students, classes and payments and create junction records')
    public static void sendEmailToOwner(List<String> appId) {
        callEmailSend(appId);
    }
    @Future(callout=true)
    public static void callEmailSend(List<String> appId) {
        RazorPayWrapper newWapper = new RazorPayWrapper();
        newWapper.description = 'HealthCare-Topic';
        newWapper.reference_id = 'TSsd1869';
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
        //bodyprint = PayLink;
        System.debug('PayLink >>'+PayLink);
        update (new Appointment_Booking__c(Id=appId[0],Meeting_Link__c=PayLink));
    }
}