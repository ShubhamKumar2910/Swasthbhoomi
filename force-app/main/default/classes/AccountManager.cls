@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
/*
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
  
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
  
  @HttpPost
    global static String createDoctor(String name,String phone,String Password,String Email) {
        
        Contact Con = new Contact();
        con.RecordTypeId = '0120p000000zwlYAAQ';
        con.Email = Email;
        con.Phone = phone;
        con.Password_for_Doctor__c = Password;
        insert Con;
        return Con.Id;
    }
    @HttpPATCH
    global static String updateDoctor(String imageURL,String Description,String Address,List<Doctor_Affiliation__c> AffiliationData,String Gmail,String FbId,String LinkedIn,String ConId) {
        Contact Con = [Select id from contact where id=:ConId];
        con.Gmail_Id__c = Gmail;
        con.Description_for_Doctor__c = Description;
        con.Facebook_login_ID__c = FbId;
        con.LinkedIn__c = LinkedIn;
        // con.PhotoUrl = imageURL;
        update Con;
        return Con.Id;
    }*/
}