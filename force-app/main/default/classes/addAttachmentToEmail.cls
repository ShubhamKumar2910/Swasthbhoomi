public class addAttachmentToEmail {
    Public Static void AddingAttachementsToEmail(String MailId,String SUbject,String Body,List<ID> attachmentIds){
        system.debug('attachmentIds'+attachmentIds);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(new String[] { MailId });
        System.debug(UserInfo.getUserEmail());
        List<Attachment> files = [SELECT Name, Body, ContentType FROM Attachment WHERE Id IN :attachmentIds];
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        for (Attachment file: files) {
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            if(file.Name.contains('.pdf')){
                efa.setFileName(file.Name);   
            }
            else{
                efa.setFileName(file.Name+'.pdf');
            }
            efa.setBody(file.Body);
            efa.setContentType(file.ContentType);
            attachments.add(efa);
        }
        message.setFileAttachments(attachments);
        message.setSubject(SUbject);
        message.setHtmlBody(Body);
        system.debug('Succesfully Fired');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
    }
    
    
    public Static void AddingAttachementsToEmail(List<wrapperForEmailAndAttach> wrapperList){
        system.debug('Wrapper Method called');
        List<Messaging.SingleEmailMessage> allEmailMessages = new List<Messaging.SingleEmailMessage>();
        for(wrapperForEmailAndAttach wrapperData : wrapperList){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(new String[] { wrapperData.leadRec.Email });
            System.debug(UserInfo.getUserEmail());
            
            message.setCcAddresses(new String[]{UserInfo.getUserEmail()});
            System.debug(message.getCcAddresses());
            
            system.debug('Wrapper Method called'+ wrapperData.leadRec.Email);
             System.debug('Inside1--------------------------------------------------'+wrapperData.attachmentRec);
             System.debug('Inside1--------------------------------------------------'+wrapperData.attachmentRec.Body);
            if(wrapperData.attachmentRec != null && wrapperData.attachmentRec.Body != null){
                System.debug('Inside1--------------------------------------------------');
                List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
                Messaging.EmailFileAttachment emailFileAttached = new Messaging.EmailFileAttachment();
                System.debug('2-----------------------------------------------------');
                emailFileAttached.setBody(wrapperData.attachmentRec.Body);
                System.debug('3------------------------------------------------------'+emailFileAttached);
                emailFileAttached.setContentType(wrapperData.attachmentRec.ContentType);
                System.debug('4------------------------------------------------------'+emailFileAttached);
                attachments.add(emailFileAttached);
                System.debug('5-------------------------------------------------------'+attachments);
                message.setFileAttachments(attachments);
            	System.debug('6-------------------------------------------------------'+message);
            }            
            message.setTargetObjectId(wrapperData.leadRec.Id);
            message.setTemplateId(wrapperData.emailTemplateRec.Id);
            
           	allEmailMessages.add(message);
            
            
            
        }
        Messaging.sendEmail(allEmailMessages);
        system.debug('Succesfully Fired');
    }
}