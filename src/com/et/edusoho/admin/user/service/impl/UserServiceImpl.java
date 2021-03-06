package com.et.edusoho.admin.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.edusoho.admin.user.bean.User;
import com.et.edusoho.admin.user.dao.UserDao;
import com.et.edusoho.admin.user.service.UserService;
import com.et.edusoho.tools.UserRolesUtils;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	public void add(Map<String, String> params) {
		userDao.add(params);
	}

	public List<User> getList(Map<String, String> params) {
		return UserRolesUtils.setRolesToUser(userDao.getList(params));
	}

	public void lock(Map<String, String> params) {
		userDao.lock(params);
	}

	public User get(Map<String, String> params) {
		return UserRolesUtils.setRolesToUser(userDao.get(params));
	}

	public List<User> getTeachers() {
		return UserRolesUtils.setRolesToUser(userDao.getTeachers());
	}

	public void update(Map<String, String> params) {
		userDao.update(params);
	}

	public int validatePwd(Map<String, String> params) {
		return userDao.validatePwd(params);
	}
}
