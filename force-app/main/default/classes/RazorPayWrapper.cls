public class RazorPayWrapper {
    
    public customer customer{get;set;}
    public String description{get;set;}
    public String reference_id{get;set;}
    public notify notify{get;set;}
    public Integer expire_by{get;set;}
    public Boolean reminder_enable{get;set;}
    public Integer first_min_partial_amount{get;set;}
    public notes notes{get;set;}
    public Boolean accept_partial{get;set;}
    public String callback_url{get;set;}
    //public String currency{get;set;}
    public String callback_method{get;set;}
    public Integer amount{get;set;}
    public class notify{
        public Boolean sms{get;set;}
        public Boolean email{get;set;}
    }
    public class notes{
        public String policy_name{get;set;}
    }
    public class customer{
        public String email{get;set;}
        public String contact{get;set;}
        public String name{get;set;}
    }
}