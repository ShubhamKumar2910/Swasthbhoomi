public class ZoomResponseWrapper{
    public String uuid;	
    public String id;	
    public String host_id;	
    public String host_email;	
    public String topic;	
    public Integer type;	
    public String status;	
    public String start_time;	
    public Integer duration;	
    public String timezone;	
    public String created_at;	
    public String start_url;
    public String join_url;	
    public String password;	
    public String h323_password;	
    public String pstn_password;	
    public String encrypted_password;
    public cls_settings settings;
    public boolean pre_schedule;
    class cls_settings {
        public boolean host_video;
        public boolean participant_video;
        public boolean cn_meeting;
        public boolean in_meeting;
        public boolean join_before_host;
        public Integer jbh_time;	
        public boolean mute_upon_entry;
        public boolean watermark;
        public boolean use_pmi;
        public Integer approval_type;
        public String audio;	
        public String auto_recording;	
        public boolean enforce_login;
        public String enforce_login_domains;	
        public String alternative_hosts;	
        public boolean close_registration;
        public boolean show_share_button;
        public boolean allow_multiple_devices;
        public boolean registrants_confirmation_email;
        public boolean waiting_room;
        public boolean request_permission_to_unmute_participants;
        public boolean registrants_email_notification;
        public boolean meeting_authentication;
        public String encryption_type;
        public cls_approved_or_denied_countries_or_regions approved_or_denied_countries_or_regions;
        public cls_breakout_room breakout_room;
        public boolean alternative_hosts_email_notification;
        public boolean device_testing;
    }
    class cls_approved_or_denied_countries_or_regions {
        public boolean enable;
    }
    class cls_breakout_room {
        public boolean enable;
    }
    public static ZoomResponseWrapper parse(String json){
        return (ZoomResponseWrapper) System.JSON.deserialize(json, ZoomResponseWrapper.class);
    }
}