public class UpadteProfilePicHelper {
    
    public static void CreateLinkForAtt(List<Attachment> AttList){
         
        system.debug('AttList[0].Id;'+AttList[0].Id);
        String parentid = AttList[0].ParentId;
       // String body = AttList[0].Body;
        if(parentid.substring(0,3) == '003'){
            Contact Con = [SELECT Image_Profile__c FROM Contact where id = :parentid];   
            con.Image_Profile__c = 'servlet/servlet.FileDownload?file='+ AttList[0].Id;
            update con;
            system.debug('Profile pic Updated');
        }
    }
}