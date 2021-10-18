/*
 * @purpose: Store authorization response to this wrapper to get access token
 * @Author: Amritesh
 */
public class AuthResponseWrapper {

	public String access_token;
	/*public String token_type;
	public Integer expires_in;
	public String refresh_token;
	public String id_token;*/

	
	public static AuthResponseWrapper parse(String json) {
		return (AuthResponseWrapper) System.JSON.deserialize(json, AuthResponseWrapper.class);
	}
}