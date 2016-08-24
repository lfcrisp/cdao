package com.baidu.user.dao;

import java.util.List;

import com.baidu.dept.entity.Dept;
import com.baidu.user.entity.User;

public interface UserDaoI {

	List deptZtreeList();

	List userList(Dept dept);

	int deleteUser(User user);

	int insertUser(User user);

	int updateUser(User user);


}
