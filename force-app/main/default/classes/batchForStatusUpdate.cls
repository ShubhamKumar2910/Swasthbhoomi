public class batchForStatusUpdate implements  Database.Batchable<sObject>{
      public  Database.QueryLocator start(Database.BatchableContext BC){
        string value = 'Not Contacted';
        return Database.getQueryLocator('SELECT Id,Status FROM Lead WHERE Status =:value');
      }
    public void execute(Database.BatchableContext BC, List<Lead> Scope){
        System.debug('Scope'+Scope);
        List<Lead> leadListToBeUpdated = new List<Lead>(); 
        for(Lead leadRec : Scope){
            leadRec.Status = 'Follow-up';
            leadListToBeUpdated.add(leadRec);
        }
        System.debug('leadListToBeUpdated'+leadListToBeUpdated);
        update leadListToBeUpdated;
        
    }
    public void finish(Database.BatchableContext BC){}

}