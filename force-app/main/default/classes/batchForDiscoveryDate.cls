global  class batchForDiscoveryDate implements Database.Batchable<sObject> {
    global  Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator('SELECT Name,OwnerId,Demo_Date__c,Id,Email FROM Lead WHERE Demo_Date__c != null');
    }
    public void execute(Database.BatchableContext BC, List<Lead> Scope){
        List < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
        for(Lead ld : Scope){
            User us =  [select name,Email from user where id=:ld.OwnerId];
            Date mydate = ld.Demo_Date__c;
            if(system.today() == mydate.addDays(-1)){
                if(us.Email != null){
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new String[] {us.Email});
                    email.setSubject('Hey Dude you have ur representation tomorrow be prepared!!'); 
                    email.setPlainTextBody('Dear user, Your demo is tommorow');
                    emails.add(email);
                }
                Messaging.sendEmail(emails);
            }
        }
    }

public void finish(Database.BatchableContext BC){}
}