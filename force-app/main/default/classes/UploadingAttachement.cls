@RestResource(urlMapping='/v1/UploadAtt/')
global  class UploadingAttachement {
    @HttpPost
    global static Attachment getPicklistValues() {
        String jsonString = RestContext.request.requestBody.toString();
        
        JSON2Apex data = (JSON2Apex)JSON.deserialize(jsonString, JSON2Apex.class);
        String Body = data.Base64Data;//it will be coming as blob data from there..
        String RecordId = data.ParentId;
        String FileName = data.FileName;
        String contentType = data.contentType;
        //Body = EncodingUtil.urlDecode(Body,'UTF-8');
        system.debug('Body'+Body+'RecordId'+RecordId+'FileName'+FileName);
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = RecordId;
        oAttachment.Body = EncodingUtil.base64Decode(Body);
        oAttachment.Name = FileName;
        oAttachment.ContentType = contentType;
        insert oAttachment;
        return oAttachment;
    }
 }