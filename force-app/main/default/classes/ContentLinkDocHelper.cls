public class ContentLinkDocHelper {
    
    public static void CreateContentLinkDocHelper(List<ContentVersion> AppList){
        ID conDocument = [Select ContentDocumentID from ContentVersion where ID=:AppList[0].ID].ContentDocumentID;
        for(ContentVersion app : AppList)
        {
            if(app.Description != null && app.Description != ''){
                ContentDocumentLink conDocLink = new ContentDocumentLink();
                conDocLink.LinkedEntityId = app.Description;
                conDocLink.ContentDocumentId = conDocument;
                insert conDocLink;       
                system.debug('conDocLink'+conDocLink.Id);        
            }
        }
    }

}