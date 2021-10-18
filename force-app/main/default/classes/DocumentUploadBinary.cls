@RestResource(UrlMapping='/DocumentUploadBinary/*')
global class DocumentUploadBinary {
    @httpPost
    global static void uploadDocument(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Id accID = req.params.get('accID');
        String contentType = req.params.get('contentType');
        String name = req.params.get('name');        
        //insert contentVersion
        contentVersion cVersion = new contentVersion();
        cVersion.PathOnClient = name;
        cVersion.title = name;
        cVersion.versionData = req.requestBody;
        insert cVersion;        
        ID conDocument = [Select ContentDocumentID from ContentVersion where ID=:cVersion.ID].ContentDocumentID;
        //insert ContentDocumentLink
        ContentDocumentLink conDocLink = new ContentDocumentLink();
        conDocLink.LinkedEntityId = accID;
        conDocLink.ContentDocumentId = conDocument;
        insert conDocLink;       
        RestContext.response.addHeader('content-Type','application/json');
        //RestContext.response.responseBody = Blob.valueOf(generateJSON('SUCCESS', conDocument,'' ));        
    }
}