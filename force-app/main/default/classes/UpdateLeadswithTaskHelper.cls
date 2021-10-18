public class UpdateLeadswithTaskHelper {
    
    public static void creatingTaskForLead(List<lead> LeadList){
        try{
            
            for(Lead ldRec : [SELECT Id,Status FROM Lead Where Id in :  LeadList ]){
                if(ldRec.Status == 'Contacted' || ldRec.Status == 'Follow-up'){
                    Task tk = new Task();
                    tk.Subject = 'Be in Touch';
                    tk.Priority = 'High';
                    tk.Status = 'In Progress';
                    tk.WhoId =  ldRec.Id;
                    insert tk;   
                }
            }
        }
        
        catch(exception ex){
            system.debug('Error==>'+ex.getMessage()+'Error@==>'+ex.getLineNumber());
        }
    }
    public static void sendemailAttachonstatusupdate(List<lead> LeadList){
        try{ 
            List<wrapperForEmailAndAttach> emailRecWrapList = new List<wrapperForEmailAndAttach>(); 
            set<Id> industryDemoIdList = new set<Id>(); 
            
            List<Industry_Demo__c> listOfIndustry = [Select id,Name,Email_Template_Name__c from Industry_Demo__c];
            
            for(Industry_Demo__c industryRec : listOfIndustry){
                industryDemoIdList.add(industryRec.Id);
            }
            System.debug('industryDemoIdList----------------'+industryDemoIdList);
            List<EmailTemplate> templateList =  [select Name,Id,Subject,Body,HtmlValue from EmailTemplate];
            Map<String,EmailTemplate> emailTempMap = new Map<String,EmailTemplate>();
            for(EmailTemplate email:templateList){
                emailTempMap.put(email.Name,email);
            }
            
            List<Attachment> attachmentList = [SELECT Id,Name,Body,ContentType FROM Attachment Where ParentId In: industryDemoIdList];
            Map<String,Attachment> attachmentMap = new Map<String,Attachment>();
            
            for(Attachment attach : attachmentList){
                attachmentMap.put(attach.Name, attach);
            }
            System.debug('attachmentMap--------------'+attachmentMap);
            for(Lead ldRec : LeadList){
                if(ldRec.Status == 'Contacted' ){
                    emailRecWrapList.add(new wrapperForEmailAndAttach(ldRec,emailTempMap.get(ldRec.Industry),attachmentMap.get(ldRec.Industry)));
                    
                }	
                if(!emailRecWrapList.isempty()){
                    addAttachmentToEmail.AddingAttachementsToEmail(emailRecWrapList); 
                }
            }
        }
        catch(exception ex){
            system.debug('Error==>'+ex.getMessage()+'Error@==>'+ex.getLineNumber());
        }
    }
}