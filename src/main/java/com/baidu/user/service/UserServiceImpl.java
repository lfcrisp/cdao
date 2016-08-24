package com.baidu.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.dept.entity.Dept;
import com.baidu.user.dao.UserDaoI;
import com.baidu.user.entity.User;


@Service
public class UserServiceImpl implements UserServiceI{

	@Autowired
	private UserDaoI dao;

	public List deptZtreeList() {
		return dao.deptZtreeList();
	}

	public List userList(Dept dept) {
		return dao.userList(dept);
	}

	public boolean deleteUser(User user) {
		int i=dao.deleteUser(user);
		return i>0;
	}

	public boolean insertUser(User user) {
		int i=dao.insertUser(user);
		return i>0;
	}

	public boolean updateUser(User user) {
		int i=dao.updateUser(user);
		return i>0;
	}

	
}
