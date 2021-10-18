public class wrapperForEmailAndAttach {
    public Lead leadRec{get;set;}
    public EmailTemplate emailTemplateRec{get;set;}
    public Attachment attachmentRec{get;set;}
    
    public wrapperForEmailAndAttach(Lead leadRec, EmailTemplate emailTemplateRec, Attachment attachmentRec){
        this.leadRec = leadRec;
        this.emailTemplateRec = emailTemplateRec;
        this.attachmentRec = attachmentRec;
        
    }
    
}