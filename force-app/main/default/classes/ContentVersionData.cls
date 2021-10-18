@RestResource(urlMapping='/ContentVersionData/*')
global with sharing class ContentVersionData {
    @HttpGet
    global static void getContentVersionData() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String parentId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        ContentDocumentLink cdLink = [SELECT ContentDocumentId,Id,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = 'a0o0p000000H4Qa'][0];
        system.debug('cdLink'+cdLink.ContentDocumentId);
        ContentVersion cv = [SELECT VersionData,CreatedDate FROM ContentVersion WHERE ContentDocumentId =:cdLink.ContentDocumentId];
        
        String bodyEncoded = EncodingUtil.base64Encode(cv.VersionData);
        dateTime CreatedDate = cv.CreatedDate;
        ContentVersionWrapper fbw = new ContentVersionWrapper(); 
        
        ContentVersionWrapper.Body mess= new ContentVersionWrapper.Body();
        mess.Body = bodyEncoded;
        
        ContentVersionWrapper.CreatedDate cd= new ContentVersionWrapper.CreatedDate();
        cd.CreatedDate = CreatedDate;
        
        ContentVersionWrapper.parent_id pId= new ContentVersionWrapper.parent_id();
        pId.parent_id = cdLink.LinkedEntityId;
        
         
        ContentVersionWrapper.Fields feild= new ContentVersionWrapper.Fields();
        feild.Body = mess;
        feild.CreatedDate = cd;
        feild.parent_id = pId;
        system.debug('jsonString'+feild); 
        system.debug('bodyEncoded'+bodyEncoded);
    }
}