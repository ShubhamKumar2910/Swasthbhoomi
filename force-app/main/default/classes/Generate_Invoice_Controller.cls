global class Generate_Invoice_Controller {
    /*
    
    public String currentRecordId {get; set;}
    public Account accountDetails {get; set;}
    public Invoice_details__c invDetails {get; set;}
    public string currencyType {get;set;}
    public Date generationDate {get;set;}
    global Generate_Invoice_Controller(){
        
        currentRecordId =  ApexPages.CurrentPage().getparameters().get('id');
        system.debug('currentRecordId===>'+currentRecordId);
        accountDetails = [select name,id,BillingStreet, BillingCity, BillingState,Phone, BillingPostalCode,BillingCountry,website,Per_Hour_Rate__c,Is_Foreign_Client__c,GSTIN__c,(select name,id,Description__c,Start_Date__c,End_Date__c,Resource_Name__c  ,Hours__c,Genration_Date__c,Due_Date__c,Balance_Due__c,
                                                                                                                                                                         Discount__c,GST__c,Other_Charges__c,Total__c,Total_Tax__c,Sub_Total__c,Sub_Total_Less_Discount__c from invoices__r ORDER BY lastmodifieddate DESC limit 1) from Account where id=:currentRecordId];
                
        
        
        if(accountDetails.invoices__r[0].Genration_Date__c != null){
            generationDate = accountDetails.invoices__r[0].Genration_Date__c;
        }
        else if(accountDetails.invoices__r[0].Genration_Date__c == null){
            Date invoiceGenerationDate =  accountDetails.invoices__r[0].Start_Date__c;
            Integer month = invoiceGenerationDate.Month();
            if(month<12){
                month = month + 1;
                String stringMonthval = String.valueOf(month);
                Integer year = invoiceGenerationDate.Year();
                String stringYear =  String.valueOf(year);
                String startingDate  = '1';
                generationDate = date.parse(stringMonthval+'/'+startingDate+'/'+stringYear);
            }
            else if(month == 12){
                Date invoiceGeneratedDate =  accountDetails.invoices__r[0].Start_Date__c;
                month = 1;
                String stringMonthval = String.valueOf(month);
                Integer year = invoiceGeneratedDate.Year();
                year = year + 1;
                String stringYear =  String.valueOf(year);
                String startingDate  = '1';
                generationDate = date.parse(stringMonthval+'/'+startingDate+'/'+stringYear);//
            }
        }
        
        
        
        if(accountDetails.Is_Foreign_Client__c == true){
            currencyType = '$';
        }
        else if(accountDetails.Is_Foreign_Client__c == false){
            currencyType = 'INR';
        }
        system.debug('accountDetails==>'+accountDetails);
        //custom setting
        invDetails = [select name,Bank_Name__c,Company_Name__c,Account_Number__c,Bank_IFSC_Code__c,Company_PAN__c,Company_TAN__c,GST_Reg_No__c,Address__c,Phone__c,Bank_Swift_Code__c from Invoice_details__c where name ='UTILLABS'];
        system.debug('invDetails==>'+invDetails);
    }
    
    
    @AuraEnabled
    global static String attachPDF(string accId) {
        Account accRecord=[select name,id,(select Start_Date__c from invoices__r ORDER BY lastmodifieddate DESC limit 1) from account where id =:accId];
        
        //generate and attach the PDF document
        PageReference pdfPage = Page.Generate_Invoice; //create a page reference to our pdfDemo Visualforce page, which was created from the post https://interactiveties.com/blog/2015/render-visualforce-pdf.php
        pdfPage.getParameters().put('id',accRecord.Id);
        
        Blob pdfBlob; //create a blob for the PDF content
        pdfBlob = pdfPage.getContent(); //generate the pdf blob
        
        Date strtDate = accRecord.invoices__r[0].Start_Date__c;
        Integer monthIntVal = strtDate.Month(); //get month integer value
        string monthStrVal = convertNumberToMonth(monthIntVal);         
        if(monthStrVal == ''&& monthStrVal == null) monthStrVal = 'Invoice';
        Attachment attach = new Attachment(parentId = accRecord.Id, Name = 'UtilitarianLab-Invoice-'+monthStrVal+'.pdf', body = pdfBlob); //create the attachment object
        insert attach;
        //return pageWhereWeWantToGo; //send the User on their way  
        return 'Success';
    }
    
    webservice static String attachPDFClassic(string accId) {
        Account accRecord=[select name,id from account where id =:accId];
        //generate and attach the PDF document
        PageReference pdfPage = Page.Generate_Invoice; //create a page reference to our pdfDemo Visualforce page, which was created from the post https://interactiveties.com/blog/2015/render-visualforce-pdf.php
        pdfPage.getParameters().put('id',accRecord.Id);
        
        Blob pdfBlob; //create a blob for the PDF content
        //otherwise, we are in testing context and getContent() gets funky so create the blob manually
        //pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        pdfBlob = pdfPage.getContent();
        
        Attachment attach = new Attachment(parentId = accRecord.Id, Name = 'pdfAttachmentDemo.pdf', body = pdfBlob); //create the attachment object
        insert attach;
        //return pageWhereWeWantToGo; //send the User on their way  
        return 'Success';
    }
    @AuraEnabled
    global static void sendEmail(string accId) {
        try{
            list<Contact> conRecords = [select name,id,Email,Contact_Role__c,FirstName from Contact where AccountId =:accId AND Contact_Role__c = 'Finance'];
            system.debug(conRecords);
            Invoice__c invDetails = [select name,Due_Date__c from Invoice__c where Account__r.id =:accId ORDER BY lastmodifieddate DESC limit 1];
            system.debug(invDetails);
            EmailTemplate et=[Select id, Name, DeveloperName, Subject, Body, HtmlValue from EmailTemplate where name = 'send Invoice' limit 1];
            Attachment files = [SELECT Name, Body, ContentType FROM Attachment WHERE ParentId =:accId ORDER BY lastmodifieddate DESC limit 1 ];
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            system.debug('mails'+mails);
            for (Contact ct : conRecords) {
                // Step 1
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(files.Name);
                efa.setBody(files.Body);
                efa.setContentType(files.ContentType);
                
                // Step 2: Set list of recipients who will get the email
                List<String> recipients = new List<String>();
                
                recipients.add(ct.Email);
                system.debug('recipients------'+recipients);
                mail.setToAddresses(recipients);
                
                //Step 3: Set sender information
                mail.setReplyTo('test@email.com');
                mail.setSenderDisplayName('Test Organization');
                
                // Step 4. Generate Content!
                
                //String body = et.Body;
                String subject = et.Subject;
                system.debug('subject'+subject);
                //subject = subject.replace('{!Contact.FirstName}', ct.FirstName);
                String htmlBody = et.HtmlValue;
                system.debug('htmlBody'+htmlBody);
                system.debug('Contact'+ct);
                system.debug('ct.FirstName'+ct.FirstName);
                htmlBody = htmlBody.replace('{!Contact.Name}', ct.FirstName);
                htmlBody = htmlBody.replace('{!Invoice__c.Name}', invDetails.Name);       
                
                String plainBody = et.Body;
                system.debug('invDetails.Name'+invDetails.Name);
                plainBody = plainBody.replace('{!Contact.Name}', ct.FirstName);
                plainBody = plainBody.replace('{!Invoice__c.Name}', invDetails.Name);
                mail.setPlainTextBody(plainBody);
                mail.setSubject(subject);
                mail.setHtmlBody(htmlBody);
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] { efa });
                //mail.setHtmlBody(body);
                
                // Step 5. Add to list
                mails.add(mail);
            }
            
            //Step 6: Send all collected emails
            Messaging.sendEmail(mails);
        }catch(Exception e){
            System.debug('Error Line==>'+e.getLineNumber()+'Error Message==>'+e.getMessage());
        }
        
    }
    private static String convertNumberToMonth(integer monthIntVal){
        String month = '';
        if(monthIntVal > 0 && monthIntVal <13){
            
            if(monthIntVal == 1){
                month =  'January';   
            }else if(monthIntVal == 2){
                month = 'February';   
            }else if(monthIntVal == 3){
                month = 'March';   
            }else if(monthIntVal == 4){
                month = 'April';   
            }else if(monthIntVal == 5){
                month = 'May';       
            }else if(monthIntVal == 6){            
                month = 'June';   
            }else if(monthIntVal == 7){
                month = 'July';   
            }else if(monthIntVal == 8){
                month = 'August';   
            }else if(monthIntVal == 9){
                month = 'September';   
            }else if(monthIntVal == 10){
                month = 'October';  
            }else if(monthIntVal == 11){
                month = 'November';  
            }else{
                month = 'December';
            }
        }
        return month; 
    }*/
}