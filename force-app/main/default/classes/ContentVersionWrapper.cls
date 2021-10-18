public class ContentVersionWrapper {
    public class Fields {
        public Body Body;
        public CreatedDate CreatedDate;
        public parent_id parent_id;
    }
    
    public Fields fields;
    
    public class Body {
        public String Body;
    }
    public class CreatedDate {
        public dateTime CreatedDate;
    }
    public class parent_id {
        public String parent_id;
    }
   
    public static ContentVersionWrapper parse(String json) {
        return (ContentVersionWrapper) System.JSON.deserialize(json, ContentVersionWrapper.class);
    }  
}