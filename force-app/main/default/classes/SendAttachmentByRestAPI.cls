public class SendAttachmentByRestAPI {
    private final String clientId =   '3MVG9n_HvETGhr3BCK8XntxzLOntIoGgoZcZuV3DniFPCItOlhpeB8drfSpbyjrb2x27aqKM.5mvoMRydyBKo';
    private final String clientSecret = '50BC02950F0200AC55A9420C60D0FAE85753A0C64672CE9485DE5C713D6BD61B';
    private final String username = 'adyadav42@salesforce.com';
    private final String password = 'Algo@123rSk8lzZnqsdya4QuPmTIi9oZ';
    public class deserializeResponse {
        public String id;
        public String access_token;
        public string instance_url;
    }    
    public String getAccessToken (){
        String reqbody = 'grant_type=password&client_id='
            +clientId+'&client_secret='
            +clientSecret+'&username='
            +username+'&password='+password;        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://adyadav42-dev-ed.my.salesforce.com/services/oauth2/token');        
        req.setMethod('POST');
        req.setBody(reqbody);
        //req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        HttpResponse res = h.send(req);
        deserializeResponse response = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        system.debug('@@@@access_token@@'+response );
        return response.access_token;
    }
    public static void sendAttachement(){
        //get Access Tocken
        SendAttachmentByRestAPI accessTk = new SendAttachmentByRestAPI();
        String accessToken;
        accessToken = accessTk.getAccessToken();
        System.debug('accessToken==='+accessToken);        
        String attchParentId;
        String attchBody;
        string reqBody;        
        ContentVersion conDoc =  [SELECT Id, Title, VersionData FROM ContentVersion where ID= '0682x000004Ki1CAAS'];
        system.debug('conDoc==='+conDoc);
        //get ContentVersion body
        String bodyEncoded = EncodingUtil.base64Encode(conDoc.VersionData);
        Id accID = '0012w00000LR4JjAAL';        
        if(accessToken != Null){
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://adyadav42-dev-ed.my.salesforce.com/services/apexrest/addi/DocumentUploadBinary?accID='+accID+'&contentType=application/JSON&name=DocUploads.pdf');             
            req.setMethod('POST');
            system.debug('bodyEncoded===='+bodyEncoded);
            req.setBody('');
            req.setHeader('Authorization','Bearer '  +accessToken);
            req.setHeader('Content-Type','application/json');
            //req.setHeader('accept','application/json');
            System.debug('END-POINT===='+req.getEndpoint());
            HttpResponse res = h.send(req);            
        } 
    }    
}