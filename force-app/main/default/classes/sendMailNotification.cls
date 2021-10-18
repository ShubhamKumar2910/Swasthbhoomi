public class sendMailNotification {
    public static void sendEmailToSalesTeam(map<id, Lead> newLeadMap,map<id, Lead> oldLeadMap){
        set<Id> leadId = new set<Id>();
        for(Lead ld : newLeadMap.Values()){
            if(ld.Discovery_Demo_Date__c != null){
                leadId.add(ld.Id); 
            }
      }
        for(Lead ld : [Select id,Email,Discovery_Demo_Date__c From Lead Where id in :newLeadMap.keyset()]){
            if(ld.Discovery_Demo_Date__c != null){
            Date mydate = ld.Discovery_Demo_Date__c;
                if(system.today() == mydate.addDays(-1)){
                    
                }    
            }
            
        }
    }
}