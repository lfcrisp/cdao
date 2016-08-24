package com.baidu.user.service;

import java.util.List;

import com.baidu.dept.entity.Dept;
import com.baidu.user.entity.User;

public interface UserServiceI {

	List deptZtreeList();

	List userList(Dept dept);

	boolean deleteUser(User user);

	boolean insertUser(User user);

	boolean updateUser(User user);


}
