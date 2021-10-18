public class AccessTokenWrapper {
    public String access_token;	//ya29.a0ARrdaM9LVwM_BGkU1H9s-IcOVG7DgQuwMz4UuESJTsIzLtCv-0dkaLW_bmzZIi58qB-MkGIRYuok43Na4xtbdoyAn331RvzkqItyNS_dhUyKLq_4RitbiwVhFtVzRQ1zxZpbthtO2TJ1iOcdr31hqS6JIBbwyQ
    public Integer expires_in;	//3596
    public String scope;	//https://www.googleapis.com/auth/calendar
    public String token_type;	//Bearer
    public static AccessTokenWrapper parse(String json){
        return (AccessTokenWrapper) System.JSON.deserialize(json, AccessTokenWrapper.class);
    }
}