public class ContactTriggerHelper {
    
    public static void CheckDuplicateEmail(List<Contact> ConList){
        
        List<String> Emails = new List<String>();
        for(Contact Con : ConList){
            Emails.add(con.Email);
        } 
        List<Contact> ExistingEmails = [Select id from Contact where email IN: Emails];
        if(ExistingEmails.size() > 0 ){
            for(Contact newCon : ConList){
                newCon.adderror('We have a Patient with the same E-mail Id');
            }
        }
    }
}