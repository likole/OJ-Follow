package entity;

public class User {
	private int uid;
	private String username;
	private String password;
	private String oid;
	private String email;
	private boolean email_valid;

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isEmail_valid() {
		return email_valid;
	}

	public void setEmail_valid(boolean email_valid) {
		this.email_valid = email_valid;
	}

	@Override
	public String toString() {
		return "User [uid=" + uid + ", username=" + username + ", password=" + password + ", oid=" + oid + ", email="
				+ email + ", email_valid=" + email_valid + "]";
	}

}
