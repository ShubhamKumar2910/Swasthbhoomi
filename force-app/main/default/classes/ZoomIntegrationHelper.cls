public class ZoomIntegrationHelper {
    
    public static String generateAcessToken(String Code){
        String endPoint ;
        String endpointURL = 'https://zoom.us/oauth/token';
        code =  'lRAGFKDT1L_fm45JlMBSpqfqOZIjsWhpw';
        String redirectURI = 'https://sales-production--healthcare.my.salesforce.com/';
        String cliendId = 'DQgsH8RmS6eZoVT7eSTUVg';
        String clientSecret = 'JZ0yYFJlWM6knM3JXN0AEzCCfjzfmrmlZsNb';
        String authorization_code ;
        endPoint = endpointURL + '?code='+code+'&redirect_uri='+redirectURI+'&client_id='+cliendId+'&client_secret='+clientSecret+'&grant_type=client_credentials';
        
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(endPoint);
        request.setBody('');
        Http http = new Http();
        HTTPResponse res;
        
        try{
            res = http.send(request);   
            AuthResponseWrapper respWrapObj = AuthResponseWrapper.parse(res.getBody());
            system.debug('respWrapObj'+res.getBody()+'access----token'+respWrapObj.access_token);
            //return respWrapObj.code; 
            return 'Success';
        }catch(Exception e){
            system.debug('exception::'+e.getMessage()+e.getLineNumber());
            return 'Success';
        }
    } 
}