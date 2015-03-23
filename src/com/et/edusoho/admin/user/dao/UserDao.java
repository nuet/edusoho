package com.et.edusoho.admin.user.dao;

import java.util.List;
import java.util.Map;

import com.et.edusoho.login.bean.User;

public interface UserDao {

	public void add(Map<String, String> params);

	public List<User> getList(Map<String, String> params);

}