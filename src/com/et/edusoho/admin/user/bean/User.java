package com.et.edusoho.admin.user.bean;

public class User {

	private String id;// �û�ID

	private String username; // �û��˺�

	private String password; // �û���¼������

	private String name; // �û�����

	private String signature; // ����ǩ��

	private String introduction; // ���ҽ���

	private String sex; // �û��Ա�

	private String role; // �û���ɫ

	private String[] roles;

	private String email; // �û���email

	private String avatar; // �û�ͷ��

	private String locked; // �û��Ƿ���

	private String createTime; // �û�������ʱ��

	private String promoted; // ���û��Ƿ��Ƽ�

	private String promotedTime;// ���û��Ƿ��Ƽ�ʱ��

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String[] getRoles() {
		return roles;
	}

	public void setRoles(String[] roles) {
		this.roles = roles;
	}

	public String getPromoted() {
		return promoted;
	}

	public void setPromoted(String promoted) {
		this.promoted = promoted;
	}

	public String getPromotedTime() {
		return promotedTime;
	}

	public void setPromotedTime(String promotedTime) {
		this.promotedTime = promotedTime;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

}
