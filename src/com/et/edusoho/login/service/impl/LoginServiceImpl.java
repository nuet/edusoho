package com.et.edusoho.login.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.edusoho.login.bean.User;
import com.et.edusoho.login.dao.LoginDao;
import com.et.edusoho.login.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginDao loginDao;

	public User login(Map<String, String> params) {
		
		return loginDao.login(params);
	}

}
