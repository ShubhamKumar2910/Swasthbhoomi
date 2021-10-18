@RestResource(urlMapping='/v1/frgtPswrd/*')
global  class ForgotPasswordApi {
    @HttpGet
    global static String SendEmail() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String Email = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('Email'+Email);
        Contact conData = [SELECT Email,Password__c FROM Contact where Email =:Email];
        
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        List<String> sendingTo = new List<String>();
        sendingTo.add(conData.Email);
        semail.setToAddresses(sendingTo); 
        semail.setSubject('Password Recovery'); 
        semail.setPlainTextBody('Your Password is'+conData.Password__c); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        system.debug('Message have been sent successfully!!');
        return 'Success';
    }
}