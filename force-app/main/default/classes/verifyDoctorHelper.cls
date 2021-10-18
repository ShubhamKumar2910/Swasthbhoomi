public class verifyDoctorHelper {
    @auraEnabled
    public static string verificationOfDoctor(string doctorId){
        system.debug('doctorId::'+doctorId);
        List<Contact> contactListToBeUpdated = new List<Contact>();
        
        Contact contactRec = [Select id,Is_Verified__c  From Contact Where Id = : doctorId ];
        system.debug('contactRec::'+contactRec);
        system.debug('contactRec.Is_Verified__c::'+contactRec.Is_Verified__c);
        
        if(contactRec.Is_Verified__c == false){
            contactRec.Is_Verified__c = true;
            contactListToBeUpdated.add(contactRec);
        }
        else if(contactRec.Is_Verified__c == true){
            return 'Already Updated';
        }
        
        if(!contactListToBeUpdated.isEmpty()){
            update contactListToBeUpdated;
            return 'SUCCESS';
        }
         return 'Error'; 
    }
    
}